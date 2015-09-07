//
//  zhuce.h
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhuce : UIView
/**
 *  对应返回按钮的操作
 */
@property (copy,nonatomic) dispatch_block_t block;
/**
 *  对应 下一步 操作
 */
@property (copy,nonatomic) dispatch_block_t nextStepBlock;
- (IBAction)upStep:(UIButton *)sender;

- (IBAction)nextStep:(UIButton *)sender;

@end
