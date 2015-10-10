//
//  zhuce.h
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhuce : UIView

@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

//马上注册
@property (copy,nonatomic) dispatch_block_t nextStepBlock;


//返回按钮
- (IBAction)upStep:(UIButton *)sender;
//下一步
- (IBAction)nextStep:(UIButton *)sender;

@end
