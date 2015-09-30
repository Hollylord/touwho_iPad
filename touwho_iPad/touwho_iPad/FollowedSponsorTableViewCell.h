//
//  FollowedSponsorTableViewCell.h
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SponsorModel.h"

@interface FollowedSponsorTableViewCell : UITableViewCell

@property (strong,nonatomic) SponsorModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headIconIMG;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
