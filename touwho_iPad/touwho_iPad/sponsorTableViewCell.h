//
//  sponsorTableViewCell.h
//  touwho_iPad
//
//  Created by apple on 15/9/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForSponsor.h"

@interface sponsorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIconIMG;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (strong,nonatomic) ModelForSponsor *model;
@end
