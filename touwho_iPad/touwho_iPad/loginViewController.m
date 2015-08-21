//
//  loginViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

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



#pragma mark - 退出按钮
- (IBAction)quickLogin:(UIButton *)sender {
}

- (IBAction)quit:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
