//
//  SIMSubIssueTableViewCell.m
//  SIMObjc
//
//  Created by Ferris on 16/4/14.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMSubIssueTableViewCell.h"

@implementation SIMSubIssueTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier subModel:(SIMSubIssueModel *)submModel
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.subModel = submModel;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return  self;
}

@end
