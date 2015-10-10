//
//  zhuce.m
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.

#import "zhuce.h"

@implementation zhuce


- (IBAction)statusChoose:(UIButton *)sender {
    //点击投资人
    if (sender.tag == 10) {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.statusImage.image = [UIImage imageNamed:@"shenfen1"];
    }
    //点击创业者
    else {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.statusImage.image = [UIImage imageNamed:@"shenfen2"];
    }
}

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
