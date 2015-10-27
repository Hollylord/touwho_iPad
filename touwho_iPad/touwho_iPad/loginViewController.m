//
//  loginViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "loginViewController.h"
#import "profileViewController.h"
#import "splitViewController.h"
#import "zhuce.h"
#import "forgetPassword.h"

@interface loginViewController ()
- (IBAction)login:(UIButton *)sender;
- (IBAction)quit:(UIButton *)sender;
- (IBAction)zhuce:(UIButton *)sender;
- (IBAction)forgetPassword:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;


@end

@implementation loginViewController
{
    AFHTTPRequestOperationManager *mgr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mgr = [AFHTTPRequestOperationManager manager];
    //新增可接受contentType
    mgr.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/html"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark - 点击按钮
//退出
- (IBAction)quit:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    if (self.quitBlock) {
        self.quitBlock();
    }
}

//点击注册
- (IBAction)zhuce:(UIButton *)sender {
    zhuce *view = [[[NSBundle mainBundle] loadNibNamed:@"zhuce" owner:nil options:nil]firstObject];
    [self.view addSubview:view];
    view.frame = self.view.frame;
    
    
    //定义点击下一步 跳转到个人中心
    view.nextStepBlock = ^(){
        [self dismissViewControllerAnimated:YES completion:NULL];
        profileViewController *viewcontroller = [[profileViewController alloc] initWithNibName:@"profileViewController" bundle:nil];
        splitViewController *split = (splitViewController *)self.presentingViewController;
        [split showDetailViewController:viewcontroller sender:nil];
    };
    
    
    
}

//点击忘记密码
- (IBAction)forgetPassword:(UIButton *)sender {
    forgetPassword *view = [[[NSBundle mainBundle] loadNibNamed:@"forgetPassword" owner:nil options:nil]firstObject];
    [self.view addSubview:view];
    view.frame = self.view.frame;
    
    
}

//点击登录按钮 跳转个人中心控制器
- (IBAction)login:(UIButton *)sender {
    //小菊花loading
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //设置参数
    NSString *phoneNumber = self.phoneNumberView.text;
    NSString *password = self.passwordView.text;
    NSDictionary *dic = @{@"method":@"login",@"account":phoneNumber,@"password":password};
    
    //请求
    [mgr GET:SERVERURL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *result = responseObject;
        //验证成功
        if ([[[result objectForKey:@"value"] objectForKey:@"resCode"] isEqualToString:@"0"]) {
            //去除小菊花
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSString *userID = [[result objectForKey:@"value"] objectForKey:@"resValue"];
            
            //保存用户信息
            NSDictionary *dic = @{@"userName":phoneNumber,@"userID":userID};
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dic forKey:@"user"];
            [userDefault synchronize];
            
            //跳转个人中心
            [self dismissViewControllerAnimated:YES completion:NULL];
            profileViewController *viewcontroller = [[profileViewController alloc] initWithNibName:@"profileViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
            splitViewController *split = (splitViewController *)self.presentingViewController;
            [split showDetailViewController:navigationController sender:nil];
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}

//微博登录
- (IBAction)weiboLogin:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    //判断是否需要授权
    if (snsPlatform.needLogin) {
        
        //弹出授权处理页面
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            NSLog(@"%@",response);
            
            //          获取微博用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                
                NSLog(@"%@",snsAccount);
                //跳转到个人中心页面
                [self quickLogin:snsAccount.accessToken withIcon:snsAccount.iconURL withNickName:snsAccount.userName withChannel:@"3"];
            }});
    }
    //已经授权了，就不用弹出授权处理页面了. 当然微博是不会来这个方法的
    else{
        //在授权完成后调用获取用户信息的方法
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsInformation is %@",response.data);
            
            [self quickLogin:[response.data objectForKey:@"openid"] withIcon:[response.data objectForKey:@"profile_image_url"] withNickName:[response.data objectForKey:@"screen_name"] withChannel:@"2"];
        }];
    }

}

- (void)quickLogin:(NSString *)token withIcon:(NSString *)iconURL withNickName:(NSString *)nickName withChannel:(NSString *)channel{
    
    //设置参数
    NSDictionary *dic = @{@"method":@"login",@"openid":token,@"avatar_url":iconURL,@"nick_name":nickName,@"channel":channel};
    //请求
    [mgr GET:SERVERURL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *result = responseObject;
        NSLog(@"%@",[[result objectForKey:@"value"] objectForKey:@"resValue"]);
        //验证成功
        if ([[[result objectForKey:@"value"] objectForKey:@"resCode"] isEqualToString:@"0"]) {
            
            NSString *userID = [[result objectForKey:@"value"] objectForKey:@"resValue"];
            
            //保存用户信息
            NSDictionary *dic = @{@"userName":nickName,@"userID":userID,@"iconURL":iconURL};
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dic forKey:@"user"];
            [userDefault synchronize];
            
            //跳转个人中心
            [self dismissViewControllerAnimated:YES completion:NULL];
            profileViewController *viewcontroller = [[profileViewController alloc] initWithNibName:@"profileViewController" bundle:nil];
            viewcontroller.model.nickName = nickName;
            viewcontroller.model.iconURL = iconURL;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
            splitViewController *split = (splitViewController *)self.presentingViewController;
            [split showDetailViewController:navigationController sender:nil];
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//微信登录
- (IBAction)wechatLogin:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"%@",snsAccount);
            //跳转到个人中心页面
            [self quickLogin:snsAccount.accessToken withIcon:snsAccount.iconURL withNickName:snsAccount.userName withChannel:@"1"];
        }
        
    });
    
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
        
    }];
    
}
//QQ登录
- (IBAction)QQlogin:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];

    //判断是否需要授权
    if (snsPlatform.needLogin) {
        
        //弹出授权处理页面
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            NSLog(@"%@",response);
            
            //          获取微博用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                
                //跳转到个人中心页面
                [self quickLogin:snsAccount.accessToken withIcon:snsAccount.iconURL withNickName:snsAccount.userName withChannel:@"2"];
            }});
    }
    //已经授权了，就不用弹出授权处理页面了 
    else{
        //在授权完成后调用获取用户信息的方法
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsInformation is %@",response.data);
            
            [self quickLogin:[response.data objectForKey:@"openid"] withIcon:[response.data objectForKey:@"profile_image_url"] withNickName:[response.data objectForKey:@"screen_name"] withChannel:@"2"];
        }];
    }
    
    
    
}

@end
