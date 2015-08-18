//
//  splitViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "splitViewController.h"

@interface splitViewController ()

@end

@implementation splitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self.viewControllers[0];
//    self.preferredPrimaryColumnWidthFraction = 100;
    self.minimumPrimaryColumnWidth = 100;
    self.maximumPrimaryColumnWidth = 100;
    
    
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

@end
