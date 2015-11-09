//
//  ActivityDetailViewController.m
//  touwho_iPad
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "huodongViewController.h"

@interface ActivityDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityTime;
@property (weak, nonatomic) IBOutlet UILabel *activityContent;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityName.text = self.model.mTitle;
    self.activityTime.text = self.model.mTime;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - 跳转
- (IBAction)turnToNextVC:(UIButton *)sender {
    huodongViewController *nextVC = [[huodongViewController alloc] init];
    nextVC.model = self.model;
    [self.navigationController pushViewController:nextVC animated:YES];
}



@end
