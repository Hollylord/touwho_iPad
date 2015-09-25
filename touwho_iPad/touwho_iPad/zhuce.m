//
//  zhuce.m
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.

#import "zhuce.h"

@implementation zhuce
- (IBAction)riskPrompt:(UIButton *)sender {
    UIView *riskView = [[[NSBundle mainBundle] loadNibNamed:@"RiskPrompt" owner:nil options:nil] firstObject];
    [self addSubview:riskView];
    riskView.frame = self.frame;
}
- (IBAction)serviceAgreement:(UIButton *)sender {
    UIView *ServiceAgreement = [[[NSBundle mainBundle] loadNibNamed:@"ServiceAgreement" owner:nil options:nil] firstObject];
    [self addSubview:ServiceAgreement];
    ServiceAgreement.frame = self.frame;
}


- (IBAction)upStep:(UIButton *)sender {
    [self removeFromSuperview];
}

- (IBAction)nextStep:(UIButton *)sender {
    if (self.nextStepBlock) {
        self.nextStepBlock();
    }
}
- (IBAction)confirmProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
