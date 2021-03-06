//
//  shipinView.m
//  touwho_iPad
//
//  Created by apple on 15/8/20.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "shipinView.h"
#import "shipinViewController.h"

@implementation shipinView


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
- (void)setModel:(ModelForFootage *)model{
    if (_model != model) {
        _model = model;
    }
    self.nameLabel.text = model.mName;
    self.timeLabel.text = model.mCreateTime;
}

#pragma mark - 跳转
- (IBAction)turnToNextVC:(UITapGestureRecognizer *)sender {
    [TalkingData trackEvent:@"点击播放视频"];
    
    UIViewController *VC = [self viewController];
    shipinViewController *nextVC = [[shipinViewController alloc] initWithNibName:@"shipinViewController" bundle:nil];
    nextVC.footageURL = self.model.mVideoUrl;
    [VC.navigationController pushViewController:nextVC animated:YES];
}


@end
