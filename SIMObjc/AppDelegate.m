//
//  AppDelegate.m
//  SIMObjc
//
//  Created by Ferris on 16/4/5.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "AppDelegate.h"
#import "SIMMasterViewController.h"
#import "SIMDBHandler.h"
#import <MBProgressHUD.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - application cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SIMMasterViewController* masterController = [SIMMasterViewController new];
    
    //设置navigationBar
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:masterController];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setOpaque:YES];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    navigationController.navigationBar.barTintColor = mainColor;
    [navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[mainFont fontWithSize:17.0f], NSFontAttributeName,nil]];;
    [navigationController.navigationBar setNeedsLayout];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    //判断是否第一次进入
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
   if (![[userDefault objectForKey:@"firstFlag"] boolValue]) {
        //是第一次 执行初始化操作
        MBProgressHUD* progress = [MBProgressHUD showHUDAddedTo:masterController.view animated:YES];
            progress.labelFont = [mainFont fontWithSize:15.0f];
            progress.labelText = @"初始化...";
            [progress show:YES];
        [[SIMDBHandler shareDBHandler] createTableOnFirstLoadWithComletitionHandler:^(BOOL success, NSError *error) {
            if (success) {
                [progress hide:YES];
                [userDefault setBool:YES forKey:@"firstFlag"];
            }
            else
            {
                NSLog(@"%@",error);
            }
        }];
        
   }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
