//
//  CorporationViewController.m
//  touwho_iPad
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 touhu.com. All rights reserved.


#import "CorporationViewController.h"

@interface CorporationViewController ()

@end

@implementation CorporationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
