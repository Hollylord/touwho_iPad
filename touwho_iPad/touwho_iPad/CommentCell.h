//
//  commentCell.h
//  touwho_iPad
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForComment.h"

@interface CommentCell : UITableViewCell
///点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *thumb;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong,nonatomic) ModelForComment *model;

@end
