//
//  SIMSubIssueModel.h
//  SIMObjc
//
//  Created by Ferris on 16/4/7.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIMSubIssueModel : NSObject<NSCopying>
@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* url;


+ (instancetype)issuesWithUrl:(NSString*)url IssueName:(NSString*)name;

- (instancetype)initWithUrl:(NSString*)url IssueName:(NSString*)name;

@end
