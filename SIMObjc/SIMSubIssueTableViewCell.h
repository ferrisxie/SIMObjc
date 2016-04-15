//
//  SIMSubIssueTableViewCell.h
//  SIMObjc
//
//  Created by Ferris on 16/4/14.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIMSubIssueModel;
@interface SIMSubIssueTableViewCell : UITableViewCell
@property (nonatomic,retain) SIMSubIssueModel* subModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier subModel:(SIMSubIssueModel*)submModel;
@end
