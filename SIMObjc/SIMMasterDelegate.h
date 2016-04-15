//
//  SIMMasterDelegate.h
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SIMMasterSelectedHandler)(UITableView* tableView,NSIndexPath* indexPath);
@interface SIMMasterDelegate : NSObject <UITableViewDelegate>
@property (nonatomic,assign) NSArray* dataSouce;

- (instancetype)initWithDataSouce:(NSArray *)data SelectedHandler:(SIMMasterSelectedHandler)handler;
@end


