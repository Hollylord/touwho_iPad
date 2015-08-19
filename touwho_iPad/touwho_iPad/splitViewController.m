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
    
    self.minimumPrimaryColumnWidth = 100;
    self.maximumPrimaryColumnWidth = 100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:nil object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"programNotification"]) {
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"shouye"] sender:nil];
    }
    else if ([notification.name isEqualToString:@"discoveryNotification"]){
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"discoveryNavigation"] sender:nil];
    }
}

@end
