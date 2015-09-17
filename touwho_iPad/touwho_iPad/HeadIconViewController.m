//
//  HeadIconViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/17.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "HeadIconViewController.h"
#import "MyImagePickerViewController.h"

@interface HeadIconViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (IBAction)cancelClick:(UIBarButtonItem *)sender;
- (IBAction)localIconClick:(UIButton *)sender;
- (IBAction)uploadClick:(UIButton *)sender;

@end

@implementation HeadIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 按钮点击
//点击取消
- (IBAction)cancelClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//点击本地头像
- (IBAction)localIconClick:(UIButton *)sender {
    MyImagePickerViewController *headIconPicker = [[MyImagePickerViewController alloc] init];
    headIconPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    headIconPicker.delegate = self;
    headIconPicker.allowsEditing = YES;
    [self presentViewController:headIconPicker animated:YES completion:NULL];
}

//点击上传
- (IBAction)uploadClick:(UIButton *)sender {
    
}

#pragma mark - UIImagePicker代理
//点击use photo后的回调方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //退出照相机
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSLog(@"%@",image);
}

@end
