//
//  message.m
//  touwho_iPad
//
//  Created by apple on 15/9/7.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "message.h"
#import "notification.h"

@implementation message

- (void)awakeFromNib{
    //默认显示通知 界面
    notification *notificationView = [[[NSBundle mainBundle] loadNibNamed:@"notification" owner:nil options:nil] firstObject];
    [self addSubview:notificationView];
    [self layoutForNotificationView:notificationView];
    self.noticeBtn.selected = YES;
}

- (void)layoutForNotificationView:(UIView *)view{
    NSLayoutConstraint *leading  = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top      = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sliderBar attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *bottom   = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.superview layoutIfNeeded];
}

#pragma mark - 按钮点击
- (IBAction)notice:(UIButton *)sender {
    if (sender.selected) {//按钮已被选中
        return ;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.sliderBar.transform = CGAffineTransformIdentity;
    }];
    sender.selected = YES;
    self.privateMessageBtn.selected = NO;
    
    //切换到显示通知 界面
    notification *notificationView = [[[NSBundle mainBundle] loadNibNamed:@"notification" owner:nil options:nil] firstObject];
    [self addSubview:notificationView];
    [self layoutForNotificationView:notificationView];
}

- (IBAction)privateMessage:(UIButton *)sender {
    if (sender.selected) {//按钮已被选中
        return ;
    }
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat tx = self.privateMessageBtn.frame.origin.x - self.noticeBtn.frame.origin.x;
        self.sliderBar.transform = CGAffineTransformMakeTranslation(tx, 0);
    }];
    sender.selected = YES;
    self.noticeBtn.selected = NO;
    
    notification *noticeView = [self.subviews lastObject];
    [noticeView removeFromSuperview];
    
}
@end
