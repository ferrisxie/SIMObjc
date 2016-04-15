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
#import "SIMSubIssueModel.h"
#import "SIMSubIssueTableViewCell.h"
#import <UIView+FLKAutoLayoutDebug.h>
#import <JBWebViewController.h>
#import "SIMMoreViewController.h"
#import <MBProgressHUD.h>
@interface SIMMasterViewController ()<SIMDataStateFresh>
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
        masterDelegate = [[SIMMasterDelegate alloc] initWithDataSouce:data SelectedHandler:^(UITableView *tableView, NSIndexPath *indexPath) {
            SIMSubIssueTableViewCell* cell = (SIMSubIssueTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            SIMSubIssueModel* subModel = cell.subModel;
            JBWebViewController* webController = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:subModel.url] mode:JBWebViewTitleModeNative];
            [webController setWebTitle:subModel.name];
            [webController setLoadingString:subModel.name];
            [webController showFromNavigationController:self.navigationController];
        }];
                
        [self.tableView reloadData];
    }];
    
    self.tableView.delegate = masterDelegate;
    self.tableView.dataSource = masterDataSouce;
    [self.view addSubview:self.tableView];
    [self.tableView alignTopEdgeWithView:self.view predicate:@"-33"];
    [self.tableView alignBottomEdgeWithView:self.view predicate:@"0"];
    [self.tableView alignLeadingEdgeWithView:self.view predicate:nil];
    [self.tableView alignTrailingEdgeWithView:self.view predicate:nil];
    
    UIBarButtonItem* moreDetail = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(toMore:)];
    self.navigationItem.rightBarButtonItem = moreDetail;
    
    [SIMDBHandler shareDBHandler].freshDelegate = self;
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
- (void)toMore:(UIBarButtonItem*)item
{
    SIMMoreViewController* moreViewController = [[SIMMoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:moreViewController animated:YES];
}
#pragma mark 
- (void)didUpdateData:(NSArray *)issues FromServiceToDBSuccess:(BOOL)success
{
    if (success) {
        [(SIMMasterDataSouce*)self.tableView.dataSource setDataSource:issues];
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.navigationController.topViewController.view animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
        UIImageView* successView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
        successView.frame = CGRectMake(0, 0, 20, 20);
        MBProgressHUD* success = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        success.mode = MBProgressHUDModeCustomView;
        success.customView = successView;
        success.detailsLabelText = @"数据更新成功";
        success.detailsLabelFont = [mainFont fontWithSize:15.0f];
        [success hide:YES afterDelay:0.5f];
    }
}
-(void)willUpdateDataFromService
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
