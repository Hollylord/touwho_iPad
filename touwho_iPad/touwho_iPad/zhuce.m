//
//  zhuce.m
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.

#import "zhuce.h"

@implementation zhuce
{
    int second;
}

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

//返回上一页
- (IBAction)upStep:(UIButton *)sender {
    [self removeFromSuperview];
}
//点击注册
- (IBAction)nextStep:(UIButton *)sender {
    if (self.nextStepBlock) {
        self.nextStepBlock();
    }
}
//确认已阅读同意协议按钮
- (IBAction)confirmProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
}
//获取验证码
- (IBAction)getVerCode:(UIButton *)sender {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //新增可接受contentType
    mgr.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/html"];
    //responseSerializer设定返回的默认都是json,由于已经设置acceptableContentTypes了 所以不要在设置responseSerializer, 否则上面的设置就被覆盖了。
   
    //设定参数
    NSString *phoneNumber = self.phoneNumberView.text;
    //发送请求
    NSDictionary *para = @{@"method":@"getVercode",@"phone":phoneNumber};
    [mgr GET:SERVERURL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //添加一个倒计时的label
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:self.vercodeBtn.bounds];
        [self.vercodeBtn addSubview:timerLabel];
        
        //设定倒计时的总时长
        second = 30;
        
        //执行倒计时
        [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:second] afterDelay:0];

        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


//倒数
- (void)reflashGetKeyBt:(NSNumber *)sec
{
    if ([sec integerValue] == 0)
    {
        [self.vercodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.vercodeBtn.subviews.lastObject removeFromSuperview];
    }
    else
    {
        [self.vercodeBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        int i = [sec intValue];
        UILabel *label = [self.vercodeBtn.subviews lastObject];
        [label setText:[NSString stringWithFormat:@"(%i)秒后重发",i]];
        [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:i-1] afterDelay:1];
    }
    
}
@end
