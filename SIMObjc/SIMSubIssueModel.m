//
//  SIMSubIssueModel.m
//  SIMObjc
//
//  Created by Ferris on 16/4/7.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMSubIssueModel.h"

@implementation SIMSubIssueModel
+ (instancetype)issuesWithUrl:(NSString*)url IssueName:(NSString *)name
{
    return [[self alloc] initWithUrl:url IssueName:name];
}
- (instancetype)initWithUrl:(NSString*)url IssueName:(NSString*)name
{
    if(self = [super init])
    {
        self.url = url;
        self.name = name;
    }
    return  self;
}
-(id)copyWithZone:(NSZone *)zone
{
    return [SIMSubIssueModel issuesWithUrl:self.url IssueName:self.name];
}
@end
