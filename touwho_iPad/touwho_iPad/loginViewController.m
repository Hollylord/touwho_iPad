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
    //设置参数
    NSString *phoneNumber = self.phoneNumberView.text;
   
    NSString *password = self.passwordView.text;
   
    NSDictionary *dic = @{@"method":@"checkVerCode",@"phone":phoneNumber,@"password":password};
    //请求
    [mgr GET:SERVERURL parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",[responseObject description]);
        
        //跳转个人中心
        [self dismissViewControllerAnimated:YES completion:NULL];
        profileViewController *viewcontroller = [[profileViewController alloc] initWithNibName:@"profileViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
        splitViewController *split = (splitViewController *)self.presentingViewController;
        [split showDetailViewController:navigationController sender:nil];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}

//微博登录
- (IBAction)weiboLogin:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //保存用户信息
            NSDictionary *dic = @{@"userName":snsAccount.userName,@"userID":snsAccount.usid,@"token":snsAccount.accessToken,@"iconURL":snsAccount.iconURL};
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dic forKey:@"user"];
            [userDefault synchronize];
            
            //跳转到个人中心页面
            [self login:nil];
            
        }});
}

//微信登录
- (IBAction)wechatLogin:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //保存用户信息
            NSDictionary *dic = @{@"userName":snsAccount.userName,@"userID":snsAccount.usid,@"token":snsAccount.accessToken,@"iconURL":snsAccount.iconURL};
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dic forKey:@"user"];
            [userDefault synchronize];
            
            //跳转到个人中心页面
            [self login:nil];
        }
        
    });
    
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
}
//QQ登录
- (IBAction)QQlogin:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //保存用户信息
            NSDictionary *dic = @{@"userName":snsAccount.userName,@"userID":snsAccount.usid,@"token":snsAccount.accessToken,@"iconURL":snsAccount.iconURL};
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:dic forKey:@"user"];
            [userDefault synchronize];
            
            //跳转到个人中心页面
            [self login:nil];
        }});
    
    //在授权完成后调用获取用户信息的方法
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
}

@end
