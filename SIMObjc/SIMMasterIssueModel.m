//
//  SIMMasterIssueModel.m
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMMasterIssueModel.h"

@implementation SIMMasterIssueModel

+ (instancetype)issuesWithNumber:(NSInteger)number IssueName:(NSString *)name
{
    return [[self alloc] initWithNumber:number IssueName:name];
}
- (instancetype)initWithNumber:(NSInteger)number IssueName:(NSString*)name
{
    if(self = [super init])
    {
        self.number = number;
        self.name = name;
        self.selectFlag = NO;
    }
    return  self;
}
-(id)copyWithZone:(NSZone *)zone
{
    return [SIMMasterIssueModel issuesWithNumber:self.number IssueName:self.name];
}
//-(NSString *)description
//{
//    return [NSString stringWithFormat:@"id:%ld--%@",(long)self.number,self.name];
//}
@end
