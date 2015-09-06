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

@interface loginViewController ()
- (IBAction)login:(UIButton *)sender;

- (IBAction)quickLogin:(UIButton *)sender;

- (IBAction)quit:(UIButton *)sender;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)quickLogin:(UIButton *)sender {
}

#pragma mark - 点击按钮
- (IBAction)quit:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//点击登录按钮 跳转个人中心控制器
- (IBAction)login:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    profileViewController *viewcontroller = [[profileViewController alloc] initWithNibName:@"profileViewController" bundle:nil];
    splitViewController *split = (splitViewController *)self.presentingViewController;
    [split showDetailViewController:viewcontroller sender:nil];
    
    
}

@end
