//
//  loginViewController.h
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController
//点击退出的block
@property (copy,nonatomic) void (^quitBlock)();
@end
