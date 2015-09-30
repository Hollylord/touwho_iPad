//
//  ProgramsTableViewCell.h
//  touwho_iPad
//
//  Created by apple on 15/9/21.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramsModel.h"

@interface ProgramsTableViewCell : UITableViewCell

@property (strong,nonatomic) ProgramsModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *IMGView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


@end
