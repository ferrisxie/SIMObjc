//
//  SIMMasterDataSouce.h
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SIMMasterDataSouce : NSObject <UITableViewDataSource>

@property(nonatomic,copy) NSArray* dataSource;


-(instancetype)initWithData:(NSArray*)dataSouce;

@end
