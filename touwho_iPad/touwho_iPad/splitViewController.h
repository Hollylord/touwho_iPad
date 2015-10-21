//
//  splitViewController.h
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface splitViewController : UISplitViewController
//调整左侧菜单的按钮的状态
@property (copy,nonatomic) dispatch_block_t block;

@end
