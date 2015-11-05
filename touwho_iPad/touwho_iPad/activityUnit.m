//
//  activityUnit.m
//  touwho_iPad
//
//  Created by apple on 15/9/15.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "activityUnit.h"
#import "huodongViewController.h"

@implementation activityUnit

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    UIViewController *VC = [self viewController];
    huodongViewController *huodongVC = [[huodongViewController alloc]init];
    [VC.navigationController pushViewController:huodongVC animated:YES];
}

//获得当前view的控制器
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setModel:(ModelForActivity *)model{
    if (_model != model) {
        _model = model;
    }
    //状态：未开始
    if ([model.mStatus isEqualToString:@"0"]) {
        self.statusLabel.text = @"未开始";
        [self.statusLabel setBackgroundColor:[UIColor colorWithRed:255/255.0 green:98/255.0 blue:77/255.0 alpha:1.0f]];
    }
    //状态：正在进行
    else if ([model.mStatus isEqualToString:@"1"]){
        self.statusLabel.text = @"正在进行";
        [self.statusLabel setBackgroundColor:[UIColor colorWithRed:255/255.0 green:98/255.0 blue:77/255.0 alpha:1.0f]];
    
    }
    //状态：已结束
    else{
        self.statusLabel.text = @"已结束";
        [self.statusLabel setBackgroundColor:[UIColor blueColor]];
    }
    

    self.nameLabel.text = model.mTitle;
    self.timeLabel.text = model.mTime;
//    self.introductionLabel.text = model.introduction;
    
}

@end
