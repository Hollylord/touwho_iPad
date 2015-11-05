//
//  ShiPinDetailViewController.m
//  touwho_iPad
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "ShiPinDetailViewController.h"
#import "shipinViewController.h"

@interface ShiPinDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityContent;

@end

@implementation ShiPinDetailViewController

- (ModelForFootage *)model{
    if (!_model) {
        _model = [[ModelForFootage alloc] init];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityName.text = self.model.mName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 跳转
- (IBAction)turnToNextVC:(UIButton *)sender {
    shipinViewController *nextVC = [[shipinViewController alloc] initWithNibName:@"shipinViewController" bundle:nil];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}


@end
