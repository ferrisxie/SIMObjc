//
//  SIMDBHandler.h
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SIMDataStateFresh <NSObject>

- (void)willUpdateDataFromService;
/**
 *
 *
 *  @param issues  包含主 次 [Dictionary:Array=>Dictionary]
 *  @param success 成功标识符
 */
- (void)didUpdateData:(NSArray*)issues FromServiceToDBSuccess:(BOOL)success;

@end

static void*  SIMAssociateNumberKey;


typedef void(^SIMDBHandlerCompletionHandler)(BOOL success,NSError* error);
typedef void(^SIMDBQueryComletionHandler)(NSArray* data,BOOL success,NSError* error);

@interface SIMDBHandler : NSObject

@property (nonatomic,assign) id<SIMDataStateFresh> freshDelegate;

+ (instancetype)shareDBHandler;

- (void)createTableOnFirstLoadWithComletitionHandler:(SIMDBHandlerCompletionHandler)handler;

- (void)loadDataSouceFromService;

- (void)queryDataSourceFromDBWithComletionHandler:(SIMDBQueryComletionHandler)handler;

@end
