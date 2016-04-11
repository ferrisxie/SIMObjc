//
//  SIMMasterDataSouce.m
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMMasterDataSouce.h"
#import "SIMMasterIssueModel.h"
#import "SIMSubIssueModel.h"
#import "SIMMasterTableViewCell.h"

@interface SIMMasterDataSouce()
@property(nonatomic,readwrite,copy) NSArray* dataSource;
@end
@implementation SIMMasterDataSouce


-(instancetype)initWithData:(NSArray *)dataSouce
{
    if (self=[super init]) {
        self.dataSource = [dataSouce copy];
    }
    return self;
}

#pragma mark - tableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger extra = 0;
    for (SIMMasterIssueModel* model in _dataSource) {
        if (model.selectFlag==YES) {
            extra = [model.subIuuses count];
            break;
        }
    }
    return self.dataSource.count+extra;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identify = @"SIMMasterCellIdentity";
    NSInteger temp = 999;
    NSInteger extra = 0;
    for (SIMMasterIssueModel* model in _dataSource) {
        if (model.selectFlag) {
            temp = [_dataSource indexOfObject:model];
            extra = model.subIuuses.count;
            break;
        }
    }
    NSInteger rowPath = indexPath.row;
    if (indexPath.row<=temp) {
        SIMMasterIssueModel* matser = [_dataSource objectAtIndex:indexPath.row];
        SIMMasterTableViewCell* cell = [[SIMMasterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify masterModel:matser];
        cell.textLabel.text = matser.name;
        cell.textLabel.font = [mainFont fontWithSize:17.0f];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"第%ld讲",matser.number];
        return  cell;
    }
    else
    {
        if (indexPath.row<=(temp+extra)) {

            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            SIMSubIssueModel* subIsuse = [[[_dataSource objectAtIndex:temp] subIuuses] objectAtIndex:rowPath-temp-1];
            cell.textLabel.text = subIsuse.name;
            cell.textLabel.font = [mainFont fontWithSize:17.0f];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            return  cell;
        }
        else
        {
            SIMMasterIssueModel* matser = [_dataSource objectAtIndex:indexPath.row-extra];
            SIMMasterTableViewCell* cell = [[SIMMasterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify masterModel:matser];
            cell.textLabel.text = matser.name;
            cell.textLabel.font = [mainFont fontWithSize:17.0f];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"第%ld讲",matser.number];
            return  cell;
        }
    }

}

@end
