//
//  BTPickerViewController.h
//  touwho_iPad
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTPickerViewController : UIViewController

//返回地区选择的字符串
@property (copy,nonatomic) void (^regionPickerBlock)(NSString *);

@end
