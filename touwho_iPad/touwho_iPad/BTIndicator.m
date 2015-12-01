//
//  BTIndicator.m
//  touwho_iPad
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "BTIndicator.h"

@implementation BTIndicator
+ (void)showTextOnView:(UIView *)view withText:(NSString *)text withDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    [hud hide:YES afterDelay:delay];
}

+ (void)showCheckMarkOnView:(UIView *)view withText:(NSString *)text withDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Checkmark"]];
    hud.labelText = text;
    [hud hide:YES afterDelay:delay];
}

+ (void)showForkMarkOnView:(UIView *)view withText:(NSString *)text withDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ForkMark"]];
    hud.labelText = text;
    [hud hide:YES afterDelay:delay];
}

+ (UIColor *)greenColor{
    return  [UIColor colorWithHue:0.6 saturation:0.6 brightness:0.5 alpha:0.8];
}
@end


