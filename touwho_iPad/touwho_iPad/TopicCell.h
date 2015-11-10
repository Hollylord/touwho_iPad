//
//  TopicCell.h
//  touwho_iPad
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForTopic.h"

@interface TopicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *writerIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong,nonatomic) ModelForTopic *model;
@end
