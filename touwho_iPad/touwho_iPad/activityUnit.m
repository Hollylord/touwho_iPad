//
//  activityUnit.m
//  touwho_iPad
//
//  Created by apple on 15/9/15.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "activityUnit.h"
#import "ActivityDetailViewController.h"

@implementation activityUnit

#pragma mark - 跳转
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [TalkingData trackEvent:@"查看活动详情"];
    
    UIViewController *VC = [self viewController];
    ActivityDetailViewController *nextVC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    nextVC.model = self.model;
    [VC.navigationController pushViewController:nextVC animated:YES];
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
       
        [self.status setTitle:@"未开始" forState:UIControlStateNormal];
        
        [self.status setBackgroundImage:[UIImage imageNamed:@"label_imminent"] forState:UIControlStateNormal];
    }
    //状态：正在进行
    else if ([model.mStatus isEqualToString:@"1"]){
        [self.status setTitle:@"正在进行" forState:UIControlStateNormal];
        [self.status setBackgroundImage:[UIImage imageNamed:@"label_onStage"] forState:UIControlStateNormal];
    
    }
    //状态：已结束
    else{
        [self.status setTitle:@"已结束" forState:UIControlStateNormal];
        [self.status setBackgroundImage:[UIImage imageNamed:@"label_finished"] forState:UIControlStateNormal];
    }
    

    self.nameLabel.text = model.mTitle;
    self.timeLabel.text = model.mTime;
    self.address.text = model.mAddress;
    NSString *iconURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mSmallImageUrl];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:[BTNetWorking chooseLocalResourcePhoto:BODY]];
    
}

@end
