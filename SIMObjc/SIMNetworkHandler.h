//
//  SIMNetworkHandler.h
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SIMMasterIssueModel;

typedef void(^SIMNetWordCompitionHandler)(id responseObject,BOOL success);

@interface SIMNetworkHandler : NSObject


+ (instancetype)shareNetWorkHandler;

- (void)downloadDataWithCompitionHandler:(SIMNetWordCompitionHandler)compititionHandler;

@end
