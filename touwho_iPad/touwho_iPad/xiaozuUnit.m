//
//  xiaozuUnit.m
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "xiaozuUnit.h"
#import "SpecificGroupViewController.h"

@implementation xiaozuUnit
- (void)setModel:(ModelForGroup *)model{
    if (_model != model) {
        _model = model;
    }
    self.nameLabel.text = model.mName;
    
}

#pragma mark - 跳转
- (IBAction)turn2SpecificGroupController:(UITapGestureRecognizer *)sender {
    UIViewController *viewController = [self viewController];
    SpecificGroupViewController *speVC = [[SpecificGroupViewController alloc] initWithNibName:@"SpecificGroupViewController" bundle:nil];
    speVC.model = self.model;
    [viewController.navigationController pushViewController:speVC animated:YES];
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
