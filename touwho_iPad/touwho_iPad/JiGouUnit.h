//
//  JiGouUnit.h
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForJiGouUnit.h"

@interface JiGouUnit : UIView
@property (weak, nonatomic) IBOutlet UIImageView *IMGView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (strong,nonatomic) ModelForJiGouUnit *model;
@end
