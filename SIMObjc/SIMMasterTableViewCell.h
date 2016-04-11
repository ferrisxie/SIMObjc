//
//  SIMMasterTableViewCell.h
//  SIMObjc
//
//  Created by Ferris on 16/4/8.
//  Copyright (c) 2016年 Ferris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SIMMasterIssueModel;
@interface SIMMasterTableViewCell : UITableViewCell

@property(nonatomic,retain) SIMMasterIssueModel* model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier masterModel:(SIMMasterIssueModel*)model;

@end
