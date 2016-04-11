//
//  SIMMasterViewController.m
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMMasterViewController.h"
#import <UIView+FLKAutoLayout.h>
#import "SIMMasterDelegate.h"
#import "SIMDBHandler.h"
#import "SIMMasterDataSouce.h"
#import <UIView+FLKAutoLayoutDebug.h>
@interface SIMMasterViewController ()
{
    SIMMasterDelegate* masterDelegate;
    SIMMasterDataSouce* masterDataSouce;
}

@property(nonatomic,retain) UITableView* tableView;



@end


@implementation SIMMasterViewController
#pragma mark - life cycle
- (void)viewDidLoad {
        [super viewDidLoad];
    self.title = @"总览";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[SIMDBHandler shareDBHandler] queryDataSourceFromDBWithComletionHandler:^(NSArray *data, BOOL success, NSError *error) {
        masterDataSouce = [[SIMMasterDataSouce alloc] initWithData:data];
        masterDelegate = [[SIMMasterDelegate alloc] initWithDataSouce:data];
                
        [self.tableView reloadData];
    }];
    
    self.tableView.delegate = masterDelegate;
    self.tableView.dataSource = masterDataSouce;
    [self.view addSubview:self.tableView];
    [self.tableView alignTopEdgeWithView:self.view predicate:@"-31"];
    [self.tableView alignBottomEdgeWithView:self.view predicate:@"0"];
    [self.tableView alignLeadingEdgeWithView:self.view predicate:nil];
    [self.tableView alignTrailingEdgeWithView:self.view predicate:nil];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
#pragma mark


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
