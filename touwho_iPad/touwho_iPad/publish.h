//
//  publish.h
//  touwho_iPad
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPickerViewController.h"

@interface publish : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnIndustry;
@property (strong,nonatomic) BTPickerViewController *picker;
@end
