//
//  SIMMasterTableViewCell.m
//  SIMObjc
//
//  Created by Ferris on 16/4/8.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import "SIMMasterTableViewCell.h"
#import <UIView+FLKAutoLayout.h>
#import "SIMMasterIssueModel.h"
@implementation SIMMasterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier masterModel:(SIMMasterIssueModel *)model
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.model = model;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
    }
    return  self;
}
- (void)setUp
{
    UILabel* mainLable = [[UILabel alloc] initWithFrame:CGRectZero];
    mainLable.text = [NSString stringWithFormat:@"第%ld讲:%@",(long)_model.number,_model.name];
    mainLable.font = [mainFont fontWithSize:17.0f];
    [self.contentView addSubview:mainLable];
    [mainLable alignTop:@"0" bottom:@"0" toView:self.contentView];
    [mainLable alignLeadingEdgeWithView:self.contentView predicate:@"30"];
    
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unSelect"]];
    [self.contentView addSubview:imageView];
    
    imageView.tag = 100861;
    [imageView constrainWidth:@"10" height:@"10"];
    [imageView alignLeadingEdgeWithView:self.contentView predicate:@"10"];
    [imageView alignCenterYWithView:self.contentView predicate:@"0"];
    
    UILabel* subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subLabel.font = [mainFont fontWithSize:14.0f];
    [self.contentView addSubview:subLabel];
    subLabel.textAlignment = NSTextAlignmentRight;
    subLabel.text = [NSString stringWithFormat:@"共%ld节",_model.subIuuses.count];
    subLabel.textColor = [UIColor darkGrayColor];
    [subLabel alignCenterYWithView:self.contentView predicate:@"0"];
    [subLabel constrainLeadingSpaceToView:mainLable predicate:@"5"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIImageView* imageView = (UIImageView*)[self.contentView viewWithTag:100861];
    if (selected) {
        imageView.image = [UIImage imageNamed:@"onSelect"];
        
    }
    else{
        imageView.image = [UIImage imageNamed:@"unSelect"];
        
    }
    [imageView setNeedsDisplay];
    [super setSelected:selected animated:animated];
}
@end
