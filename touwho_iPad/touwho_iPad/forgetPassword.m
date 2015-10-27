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
    //如果不是11位手机号
    if (self.phoneNumberView.text.length != 11) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hub.mode = MBProgressHUDModeText;
        hub.labelText = @"手机号不正确";
        [hub hide:YES afterDelay:0.5];
        return ;
    }
    NSString *phoneNumber = self.phoneNumberView.text;
   
    NSDictionary *dic = @{@"method":@"getVercode_find",@"phone":phoneNumber};
    //请求
    [mgr GET:SERVER_API_URL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        //添加一个倒计时的label
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:self.vercodeBtn.bounds];
        [self.vercodeBtn addSubview:timerLabel];
        [self.vercodeBtn setEnabled:NO];
        
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
        [self.vercodeBtn setEnabled:YES];
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

//点击修改密码确定
- (IBAction)confirm:(UIButton *)sender {
    //判断2个密码是否一致
    if (self.password1View.text != self.password2View.text) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"两次输入密码不一致";
        [hud hide:YES afterDelay:1];
        return ;
    }
    else if ([self.password1View.text isEqualToString:@""]){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"密码不能为空";
        [hud hide:YES afterDelay:1];
        return ;
    }
    
    //设置参数
    NSString *newPassword = self.password2View.text;
    NSDictionary *para = @{@"method":@"checkVerCode_find",@"phone":self.phoneNumberView.text,@"ver_code":self.vercodeInputView.text,@"password":newPassword};
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"修改密码成功";
        [hud hide:YES afterDelay:1];
        hud.completionBlock = ^(){
            [self upStep:nil];
        };
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

@end
