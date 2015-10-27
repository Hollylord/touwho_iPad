//
//  forgetPassword.m
//  touwho_iPad
//
//  Created by apple on 15/9/7.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "forgetPassword.h"

@implementation forgetPassword
{
    int second;
    AFHTTPRequestOperationManager *mgr;
}
//创建一个afnManager
- (void)awakeFromNib{
    mgr = [AFHTTPRequestOperationManager manager];
    //新增可接受contentType
    mgr.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/html"];
    
}
- (IBAction)upStep:(UIButton *)sender {
    [self removeFromSuperview];
}
//点击获取验证码
- (IBAction)getVercode:(UIButton *)sender {
    //设置参数
    NSString *phoneNumber = self.phoneNumberView.text;
   
    NSDictionary *dic = @{@"method":@"getVercode_find",@"phone":phoneNumber};
    //请求
    [mgr GET:SERVERURL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        //添加一个倒计时的label
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:self.vercodeBtn.bounds];
        [self.vercodeBtn addSubview:timerLabel];
        
        //设定倒计时的总时长
        second = 60;
        
        //执行倒计时
        [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:second] afterDelay:0];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//倒计时
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

//点击确定
- (IBAction)confirm:(UIButton *)sender {
}

@end
