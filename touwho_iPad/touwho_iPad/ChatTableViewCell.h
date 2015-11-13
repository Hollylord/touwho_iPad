//
//  ChatTableViewCell.h
//  touwho_iPad
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelChating.h"

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (strong,nonatomic) ModelChating *model;
@end
