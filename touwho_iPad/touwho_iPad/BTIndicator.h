//
//  BTIndicator.h
//  touwho_iPad
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTIndicator : NSObject
///只显示文字
+ (void)showTextOnView:(UIView *)view withText:(NSString *)text withDelay:(NSTimeInterval)delay;
///打钩+文字
+ (void)showCheckMarkOnView:(UIView *)view withText:(NSString *)text withDelay:(NSTimeInterval)delay;
///打叉+文字
+ (void)showForkMarkOnView:(UIView *)view withText:(NSString *)text withDelay:(NSTimeInterval)delay;

@end

@interface BTIndicator ()
+ (UIColor *)greenColor;

@end