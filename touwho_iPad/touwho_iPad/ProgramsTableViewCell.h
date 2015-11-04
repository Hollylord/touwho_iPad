//
//  ProgramsTableViewCell.h
//  touwho_iPad
//
//  Created by apple on 15/9/21.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMyProgram.h"
#import "ModelMyInstitution.h"

@interface ProgramsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *IMGView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (strong,nonatomic) ModelMyProgram *model;
@property (strong,nonatomic) ModelMyInstitution *model_b;

@end
