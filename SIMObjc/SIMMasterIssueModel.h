//
//  SIMMasterIssueModel.h
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIMMasterIssueModel : NSObject<NSCopying>

@property(nonatomic,strong) NSString* name;
@property(nonatomic,assign) NSInteger number;

@property(nonatomic,copy) NSArray* subIuuses;
@property(nonatomic) BOOL selectFlag;
+ (instancetype)issuesWithNumber:(NSInteger)number IssueName:(NSString*)name;

- (instancetype)initWithNumber:(NSInteger)number IssueName:(NSString*)name;


@end



