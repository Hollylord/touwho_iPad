//
//  MyImagePickerViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/17.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "MyImagePickerViewController.h"

@interface MyImagePickerViewController ()

@end

@implementation MyImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return (UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight);
}

@end
