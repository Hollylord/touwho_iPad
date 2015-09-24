//
//  RiskTestViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/24.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "RiskTestViewController.h"

@interface RiskTestViewController ()

- (IBAction)quit:(UIBarButtonItem *)sender;

@end

@implementation RiskTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 按钮点击
- (IBAction)quit:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
