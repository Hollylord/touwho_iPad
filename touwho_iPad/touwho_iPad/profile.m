//
//  profile.m
//  touwho_iPad
//
//  Created by apple on 15/9/16.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "profile.h"
#import "profileViewController.h"

@implementation profile

- (void)awakeFromNib{
    profileViewController *VC = (profileViewController *)[self viewController];
    VC.presentBusinessCard = ^(UIImage * image){
        [self.businessCard setImage:image];
    };
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
@end
