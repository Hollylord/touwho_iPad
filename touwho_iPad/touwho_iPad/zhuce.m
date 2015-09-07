//
//  zhuce.m
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.

#import "zhuce.h"

@implementation zhuce


- (IBAction)upStep:(UIButton *)sender {
    [self removeFromSuperview];
}

- (IBAction)nextStep:(UIButton *)sender {
    if (self.nextStepBlock) {
        self.nextStepBlock();
    }
}
@end
