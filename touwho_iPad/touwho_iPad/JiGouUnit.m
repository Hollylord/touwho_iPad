//
//  JiGouUnit.m
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "JiGouUnit.h"
#import "JiGouDetailViewController.h"

@implementation JiGouUnit

- (void)setModel:(ModelForJiGouUnit *)model {
    if (_model != model) {
        _model = model;
    }
    NSString *logo = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mLogo];
    [self.IMGView sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"logo_background"]];
    self.label1.text = model.mShortName;
    self.label2.text = model.mCreateTime;
    self.label3.text = model.mName;
    
}

#pragma mark - 跳转
- (IBAction)turnToNextVC:(UITapGestureRecognizer *)sender {
    UIViewController *VC = [self viewController];
    if (!USER_ID) {
        [BTIndicator showTextOnView:VC.view withText:@"请登录后再试！" withDelay:1];
        return ;
    }
    
    JiGouDetailViewController *jiGouVC = [[JiGouDetailViewController alloc] initWithNibName:@"JiGouDetailViewController" bundle:nil];
    //传递数据
    jiGouVC.model = self.model;
    [VC.navigationController pushViewController:jiGouVC animated:YES];
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
