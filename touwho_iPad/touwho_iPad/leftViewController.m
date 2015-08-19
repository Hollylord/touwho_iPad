//
//  leftViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "leftViewController.h"


@interface leftViewController () <UISplitViewControllerDelegate>

- (IBAction)me:(UIButton *)sender;

@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)me:(UIButton *)sender {
    //发送被点击的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotification" object:nil];
    
}


@end
