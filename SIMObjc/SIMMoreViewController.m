//
//  SIMMoreViewController.m
//  SIMObjc
//
//  Created by Ferris on 16/4/15.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMMoreViewController.h"
#import <MBProgressHUD.h>
#import <JBWebViewController.h>
#import "SIMDBHandler.h"

@interface SIMMoreViewController ()

@end

@implementation SIMMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
            
        default:
            return 1;
            break;
    }
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* reuseIdentify = @"SIMMoreReuseIdentify";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
    if (indexPath.section == 0) {
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"英文原版";
            break;
        case 1:
            cell.textLabel.text = @"查阅作者博客";
            break;
        default:
            break;
    }
    }
    else
    {
        cell.textLabel.text = @"重新获取数据";
    }
    // Configure the cell...
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"查阅作者博客"]) {
        JBWebViewController* webViewController = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://xferris.me"]];
        [webViewController setWebTitle:@"风雅颂"];
        [webViewController setLoadingString:@"加载中..."];
        [webViewController showFromController:self.navigationController];
    }
    else if([cell.textLabel.text isEqualToString:@"英文原版"])
    {
        JBWebViewController* webViewController = [[JBWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://www.objc.io"]];
        [webViewController setWebTitle:@"objc.io"];
        [webViewController setLoadingString:@"loading"];
        [webViewController showFromController:self.navigationController];
    }
    else if ([cell.textLabel.text isEqualToString:@"重新获取数据"])
    {
        MBProgressHUD* progross = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        progross.detailsLabelText = @"载入中...";
        progross.detailsLabelFont = [mainFont fontWithSize:15.0f];
        [[SIMDBHandler shareDBHandler] deleteDBData];
        [[SIMDBHandler shareDBHandler] loadDataSouceFromService];
    }
}


@end
