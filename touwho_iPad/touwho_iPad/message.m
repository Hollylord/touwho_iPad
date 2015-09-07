//
//  message.m
//  touwho_iPad
//
//  Created by apple on 15/9/7.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "message.h"

@implementation message

- (void)awakeFromNib{
    //
    UIView *notificationView = [[[NSBundle mainBundle] loadNibNamed:@"notification" owner:nil options:nil]firstObject];
    [self addSubview:notificationView];
    [self layoutForNotificationView:notificationView];
    NSLog(@"%@",NSStringFromCGRect(self.sliderBar.frame));
    NSLog(@"%@",NSStringFromCGRect(notificationView.frame));
}
- (void)layoutForNotificationView:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sliderBar attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.superview layoutIfNeeded];
}
- (IBAction)notice:(UIButton *)sender {
}

- (IBAction)privateMessage:(UIButton *)sender {
}
@end
