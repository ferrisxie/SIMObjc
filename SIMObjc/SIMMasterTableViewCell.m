//
//  SIMMasterTableViewCell.m
//  SIMObjc
//
//  Created by Ferris on 16/4/8.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMMasterTableViewCell.h"

@implementation SIMMasterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier masterModel:(SIMMasterIssueModel *)model
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.model = model;
    }
    return  self;
}
@end
