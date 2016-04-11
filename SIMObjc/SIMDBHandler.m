//
//  SIMDBHandler.m
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//
/**
 *  error code: 6000 6001
 *
 *
 */
#import "SIMDBHandler.h"
#import <FMDB.h>
#import "SIMNetworkHandler.h"
#import "SIMMasterIssueModel.h"
#import "SIMSubIssueModel.h"
#import <objc/runtime.h>


@implementation SIMDBHandler


+ (instancetype)shareDBHandler
{
    static SIMDBHandler* dbHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbHandler = [[self alloc] init];
    });
    return dbHandler;
}

-(void)createTableOnFirstLoadWithComletitionHandler:(SIMDBHandlerCompletionHandler)handler
{
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"sim_master.db"];
    FMDatabase *db     = [FMDatabase databaseWithPath:dbPath];
    NSError* error = nil;
    if (db) {
        [db open];
        //建表
        NSArray* sqlArray = @[@"CREATE TABLE IF NOT EXISTS sim_master_cn (id integer NOT NULL, title text NOT NULL);",@"CREATE TABLE IF NOT EXISTS sim_issues_cn (mId integer NOT NULL , title text NOT NULL, url text NOT NULL);",@"CREATE TABLE IF NOT EXISTS sim_master_en (id integer NOT NULL, title text NOT NULL);",@"CREATE TABLE IF NOT EXISTS sim_issues_en (mId integer NOT NULL , title text NOT NULL, url text NOT NULL);"];
        BOOL success = NO;
        for (NSString* createTableSql in sqlArray) {
            if (![db executeUpdate:createTableSql]) {
                [db rollback];
                error = [NSError errorWithDomain:@"在创建数据库时遇到错误，请重试" code:6000 userInfo:nil];
                success = NO;
                break;
            }
            success = YES;
        }
        //获取数据
        [self loadDataSouceFromService];
        handler(success,nil);
        if ([db goodConnection]) {
            [db close];
        }
    }
    else
    {
        handler(NO,[NSError errorWithDomain:@"打开数据库失败，请重试" code:6001 userInfo:nil]);
    }
}
/**
 *  使用协议处理回调
 */
- (void)loadDataSouceFromService
{
    NSMutableArray* returnArray = [NSMutableArray array];
    if([_freshDelegate respondsToSelector:@selector(willUpdateDataFromService)])
    {
        [_freshDelegate willUpdateDataFromService];
    }
    [[SIMNetworkHandler shareNetWorkHandler] downloadDataWithCompitionHandler:^(id responseObject, BOOL success) {
        for (NSDictionary* info in (NSArray*)responseObject) {
            NSArray* keys = [info allKeys];
            NSInteger masterId ;
            NSString* masterName ;
            if ([[keys firstObject] intValue]>0) {
                masterId = (NSInteger)[[keys firstObject] integerValue];
                masterName = info[[keys firstObject]];
            }
            else
            {
                masterId = (NSInteger)[[keys lastObject] integerValue];
                masterName = info[[keys lastObject]];
            }
            
            //构造返回数组
            NSMutableArray* issues = [NSMutableArray array];
            SIMMasterIssueModel* master = [SIMMasterIssueModel issuesWithNumber:masterId IssueName:masterName];
            for (NSDictionary* iss in info[@"issues"]) {
                SIMSubIssueModel* issue = [SIMSubIssueModel issuesWithUrl:[[iss allValues] firstObject] IssueName:[[iss allKeys] firstObject]];
                [issues addObject:issue];
            }
            master.subIuuses = [issues copy];
            //            [returnArray addObject:[NSDictionary dictionaryWithObject:issues forKey:master]];
            [returnArray addObject:master];
            
        }
        //写入数据岛数据库
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"sim_master.db"];
        FMDatabase *db     = [FMDatabase databaseWithPath:dbPath];
        if (![db goodConnection]) {
            [db open];
        }
        NSArray* sqlArray = [self generateSqlWith:[returnArray copy]];
        for (NSString* sql in sqlArray) {
            if (![db executeUpdate:sql]) {
                [db rollback];
                if ([self.freshDelegate respondsToSelector:@selector(didUpdateData:FromServiceToDBSuccess:)]) {
                    [_freshDelegate didUpdateData:[returnArray copy] FromServiceToDBSuccess:NO];
                }
                NSLog(@"fuck with %@",sql);
                break;
            }
        }
        [db close];
        if ([self.freshDelegate respondsToSelector:@selector(didUpdateData:FromServiceToDBSuccess:)]) {
            [_freshDelegate didUpdateData:[returnArray copy] FromServiceToDBSuccess:YES];
        }

    }];
}
/**
 *  获取插入的sql语句
 *
 *  @param data 构造master：iuusers
 */
-(NSArray*)generateSqlWith:(NSArray*)data
{
    NSMutableArray* returnArray = [NSMutableArray array];
    for (SIMMasterIssueModel* model in data) {
        NSString* sql = [NSString stringWithFormat:@"insert into sim_master_cn (id,title) values (%ld,'%@');",(long)model.number,model.name];
        [returnArray addObject:sql];
        NSArray* issues = model.subIuuses;
        for (SIMSubIssueModel* subModel in issues) {
            NSString* newSql = [NSString stringWithFormat:@"insert into sim_issues_cn (mId,title,url) values (%ld,'%@','%@');",(long)model.number,subModel.name,subModel.url];
            [returnArray addObject:newSql];
        }
    }
    return  [returnArray copy];
}
/**
 *  从数据库读取数据
 */
-(void)queryDataSourceFromDBWithComletionHandler:(SIMDBQueryComletionHandler)handler
{
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"sim_master.db"];
    FMDatabase *db     = [FMDatabase databaseWithPath:dbPath];
    
    if (![db goodConnection]) {
        [db open];
    }
    NSString* sql = @"select * from sim_master_cn order by id";
    FMResultSet* MasterResult = [db executeQuery:sql];
    NSMutableArray* resutArray = [NSMutableArray array];
    while([MasterResult next]) {
        NSInteger number = [MasterResult intForColumn:@"id"];
        NSString* name = [MasterResult stringForColumn:@"title"];
        SIMMasterIssueModel* master = [SIMMasterIssueModel issuesWithNumber:number IssueName:name];
        [resutArray addObject:master];
    }
    for (SIMMasterIssueModel* masterModel in resutArray) {
        NSMutableArray* issueArray = [NSMutableArray array];
        NSString* sql = [NSString stringWithFormat:@"SELECT * FROM sim_issues_cn where mId=%ld;",(long)masterModel.number];
        FMResultSet* issuesResult = [db executeQuery:sql];
        while ([issuesResult next]) {
            SIMSubIssueModel* subIuuse = [SIMSubIssueModel issuesWithUrl:[issuesResult stringForColumn:@"url"] IssueName:[issuesResult stringForColumn:@"title"]];
            [issueArray addObject:subIuuse];
        }
        masterModel.subIuuses = [issueArray copy];
    }
    if([db goodConnection])
    {
        [db close];
    }
    handler([resutArray copy],YES,nil);
}
@end
