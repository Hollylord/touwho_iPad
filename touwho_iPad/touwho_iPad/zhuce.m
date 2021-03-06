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
    AFHTTPRequestOperationManager *mgr;
}
//创建一个afnManager
- (void)awakeFromNib{
    mgr = [AFHTTPRequestOperationManager manager];
    //新增可接受contentType
    mgr.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/html"];
    //responseSerializer设定返回的默认都是json,由于已经设置acceptableContentTypes了 所以不要在设置responseSerializer, 否则上面的设置就被覆盖了。
    
    //默认为投资人
    self.btn1.selected = YES;

}

- (IBAction)statusChoose:(UIButton *)sender {
    //点击投资人
    if (sender.tag == 10) {
        sender.selected = YES;
        self.btn2.selected = NO;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.statusImage.image = [UIImage imageNamed:@"shenfen1"];
    }
    //点击创业者
    else {
        sender.selected = YES;
        self.btn1.selected = NO;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.statusImage.image = [UIImage imageNamed:@"shenfen2"];
    }
}

- (IBAction)riskPrompt:(UIButton *)sender {
    [TalkingData trackEvent:@"阅读风险提示"];
    
    UIView *riskView = [[[NSBundle mainBundle] loadNibNamed:@"RiskPrompt" owner:nil options:nil] firstObject];
    [self addSubview:riskView];
    riskView.frame = self.frame;
}
- (IBAction)serviceAgreement:(UIButton *)sender {
    [TalkingData trackEvent:@"阅读服务协议"];
    
    UIView *ServiceAgreement = [[[NSBundle mainBundle] loadNibNamed:@"ServiceAgreement" owner:nil options:nil] firstObject];
    [self addSubview:ServiceAgreement];
    ServiceAgreement.frame = self.frame;
}

//返回上一页
- (IBAction)upStep:(UIButton *)sender {
    [self removeFromSuperview];
}

#pragma mark - 点击注册
- (IBAction)nextStep:(UIButton *)sender {
    //设置参数
    NSString *phoneNumber = self.phoneNumberView.text;
    NSString *vercode = self.vercodeView.text;
    NSString *password = [BTNetWorkingAPI md5:self.passwordView.text];
    NSString *userType;
    if (self.btn1.selected) {
        userType = @"1";
    }
    else {
        userType = @"2";
    }
    NSString *invitator = self.invitationView.text;
    NSDictionary *dic = @{@"method":@"checkVerCode",@"phone":phoneNumber,@"ver_code":vercode,@"password":password,@"user_type":userType,@"invester":invitator};
    
    //请求
    [mgr GET:SERVER_API_URL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *result = responseObject;
        NSLog(@"zhuce = %@",responseObject);
        //验证成功
        if ([[[[result objectForKey:@"value"] firstObject] objectForKey:@"resCode"] isEqualToString:@"0"]){
            
            NSString *userID = [[[result objectForKey:@"value"] firstObject] objectForKey:@"mID"];
            NSString *iconUrl = [[[result objectForKey:@"value"] firstObject] objectForKey:@"mAvatar"];
            
            //保存用户信息
            NSDictionary *dic = @{@"userName":phoneNumber,@"userID":userID,@"iconURL":iconUrl};
            NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithDictionary:dic];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:user forKey:@"user"];
            [userDefault synchronize];
            
            //发送更换头像的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setHeadImageView" object:nil];
            
            if (self.nextStepBlock) {
                self.nextStepBlock();
            }
            
        }
        else{
            [BTIndicator showForkMarkOnView:self withText:[[[result objectForKey:@"value"] firstObject] objectForKey:@"resValue"] withDelay:1];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
//确认已阅读同意协议按钮
- (IBAction)confirmProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - 获取验证码
- (IBAction)getVerCode:(UIButton *)sender {
    [TalkingData trackEvent:@"获取验证码"];
    
    //设定参数
    //如果不是11位手机号
    if (self.phoneNumberView.text.length != 11) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hub.mode = MBProgressHUDModeText;
        hub.labelText = @"手机号不正确";
        [hub hide:YES afterDelay:0.5];
        return ;
    }
    NSString *phoneNumber = self.phoneNumberView.text;
    //发送请求
    NSDictionary *para = @{@"method":@"getVercode",@"phone":phoneNumber};
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *resCode  = [[[responseObject objectForKey:@"value"] firstObject] objectForKey:@"resCode"];
        NSString *resValue  = [[[responseObject objectForKey:@"value"] firstObject] objectForKey:@"resValue"];
        if (![resCode isEqualToString:@"0"]) {
            [BTIndicator showTextOnView:self withText:resValue withDelay:0.5];
            return ;
        }
        
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
        [label setText:[NSString stringWithFormat:@"    (%i)秒后重发",i]];
        [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:i-1] afterDelay:1];
    }
    
}
@end
