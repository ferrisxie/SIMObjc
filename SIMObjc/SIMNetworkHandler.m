//
//  SIMNetworkHandler.m
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMNetworkHandler.h"
#import <AFNetworking.h>


static NSString* const reachabilityDomain = @"http://www.baidu.com";

@interface SIMNetworkHandler()
/**
 *  网络连接检测
 */
@property(nonatomic,retain) AFNetworkReachabilityManager* reachabilityManager;
/**
 *  请求控制器
 */
@property(nonatomic,retain) AFHTTPRequestOperationManager* afManager;
@end


@implementation SIMNetworkHandler

+(instancetype)shareNetWorkHandler
{
    static SIMNetworkHandler* networkHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkHandler = [[self alloc] init];
        if (networkHandler) {
            //初始化操作
            networkHandler.reachabilityManager = [AFNetworkReachabilityManager managerForDomain:reachabilityDomain];
            networkHandler.afManager = [AFHTTPRequestOperationManager manager];
            networkHandler.afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            networkHandler.afManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
    });
    return networkHandler;
}
/**
 *  获取数据
 */
- (void)downloadDataWithCompitionHandler:(SIMNetWordCompitionHandler)compititionHandler
{
    [self.afManager GET:serviceAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray* info = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        compititionHandler(info,YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        compititionHandler(error,NO);
    }];

}



@end
