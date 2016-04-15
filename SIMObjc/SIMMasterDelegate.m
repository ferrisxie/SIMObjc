//
//  SIMMasterDelegate.m
//  SIMObjc
//
//  Created by Ferris on 16/4/6.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMMasterDelegate.h"
#import <UIView+FLKAutoLayout.h>
#import "SIMMasterIssueModel.h"
#import "SIMMasterTableViewCell.h"
#import <objc/runtime.h>

#import "SIMSubIssueTableViewCell.h"

@interface SIMMasterDelegate()

{
    //保证其指向的始终是masterIndexPath
    NSIndexPath* _lastSelectMatserIndexPath;
    //展开的行数
    NSInteger _lastModelIssuesCount;
    //是否选中普通的cell
    BOOL _isSelectSubCell;
    //时候展开状态
    BOOL _isShowIssues;
    NSIndexPath* _willSelectIndexPath;
    SIMMasterSelectedHandler _selectedHandler;
}
@end


@implementation SIMMasterDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}

-(instancetype)initWithDataSouce:(NSArray *)data SelectedHandler:(SIMMasterSelectedHandler)handler
{
    if (self= [super init]) {
        self.dataSouce = data;
        _isShowIssues = NO;
        _lastSelectMatserIndexPath = nil;
        _lastModelIssuesCount = 0;
        _isSelectSubCell = NO;
        _selectedHandler = handler;
    }
    return  self;
}

//每次点击都deselect导致indexPath变化！！！
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isMemberOfClass:[SIMMasterTableViewCell class]]) {
        SIMMasterIssueModel* masterModel = [(SIMMasterTableViewCell*)cell model];
        if (masterModel.selectFlag) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
            return;
        }
        masterModel.selectFlag = masterModel.selectFlag?NO:YES;
        for (SIMMasterIssueModel* model in _dataSouce) {
            if (model!=masterModel) {
                model.selectFlag = NO;
            }
        }
        NSMutableArray* indexArray = [NSMutableArray array];
        for (int i=1; i<=masterModel.subIuuses.count; i++) {
            NSIndexPath* path = [NSIndexPath indexPathForRow:i+indexPath.row inSection:indexPath.section];
            [indexArray addObject:path];
        }
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
        //展开状态
        _isShowIssues = YES;
        //展开后设置最后选中的indexPath
        _lastModelIssuesCount = masterModel.subIuuses.count;
        _lastSelectMatserIndexPath = [indexPath copy];
    }
    else if([cell isMemberOfClass:[SIMSubIssueTableViewCell class]])
    {
        if (_selectedHandler) {
            _selectedHandler(tableView,indexPath);
        }
    }
    
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell && [cell isMemberOfClass:[SIMMasterTableViewCell class]]) {
        //点击masterCell
        if (_isShowIssues) {
            //展开状态
            if(indexPath.row>_lastSelectMatserIndexPath.row)
                return [NSIndexPath indexPathForRow:indexPath.row-_lastModelIssuesCount inSection:indexPath.section];
            else
                return indexPath;
        }
        return  indexPath;
    }
    else if(cell)
    {
        _isSelectSubCell = YES;
        return indexPath;
        //点击到uitableviewcell
    }
    return  indexPath;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{        //判断时候普通的Cell 是的话 不走deselect代码
    if (_isSelectSubCell) {
        _isSelectSubCell = NO;
        return nil;
    }
    return indexPath;

}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        //cell没有被销毁
        if ([cell isMemberOfClass:[SIMMasterTableViewCell class]]) {
            SIMMasterIssueModel* masterModel = [(SIMMasterTableViewCell*)cell model];
            masterModel.selectFlag = masterModel.selectFlag?NO:YES;
            for (SIMMasterIssueModel* model in _dataSouce) {
                if (model!=masterModel) {
                    model.selectFlag = NO;
                }
            }
            NSMutableArray* indexArray = [NSMutableArray array];
            for (int i=1; i<=masterModel.subIuuses.count; i++) {
                NSIndexPath* path = [NSIndexPath indexPathForRow:i+indexPath.row inSection:indexPath.section];
                [indexArray addObject:path];
            }
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationRight];
            [tableView endUpdates];
            _isShowIssues = NO;
            //  [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }
    else
    {
        //cell被销毁
        for (SIMMasterIssueModel* model in _dataSouce) {
            if (model.selectFlag) {
                model.selectFlag = NO;
                [tableView reloadData];
                break;
            }
        }
    }
}

@end
