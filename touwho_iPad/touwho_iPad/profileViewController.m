//
//  profileViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "profileViewController.h"
#import "meRight.h"
#import "meLeft.h"
#import "notification.h"
#import "OtherCenterViewController.h"

@interface profileViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet meLeft *meLeftView;
@property (strong,nonatomic) UIView *meRightView;


- (IBAction)uploadCard:(UIButton *)sender;//点击上传名片

@end

@implementation profileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加左边view
    meLeft *me         = [[[NSBundle mainBundle] loadNibNamed:@"meLeft" owner:self options:nil]firstObject];
    [self.view addSubview:me];
    [self layoutForMe:me];
    //实现点击头像操作
    me.headIconClick = ^(){
        OtherCenterViewController *otherVC = [[OtherCenterViewController alloc] initWithNibName:@"OtherCenterViewController" bundle:nil];
        [self.navigationController pushViewController:otherVC animated:YES];
    };
    
    //添加右边view
    meRight *meRightView = [[meRight alloc] init];
    [self.view addSubview:meRightView];
    self.meRightView     = meRightView;
    [self layoutForMeRight:meRightView];

    //设置右边为左边代理
    me.delegate          = meRightView;
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - 布局
//布局meLeftView
- (void)layoutForMe:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *top     = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom  = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width   = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    
    [self.view addConstraints:@[leading,top,bottom]];
    [view addConstraint:width];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view layoutIfNeeded];
    
}

- (void)layoutForMeRight:(UIView *)view{
    
    NSLayoutConstraint *top      = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom   = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width    = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:923-300];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    [self.view addConstraints:@[trailing,top,bottom]];
    [view addConstraint:width];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view layoutIfNeeded];
    
  
}


#pragma mark - 按钮点击
- (IBAction)uploadCard:(UIButton *)sender {
    //只在这里生成照相机 由于没有strong 不知道出了这个方法能不能使用
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
    }
}

#pragma mark - 照相机代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    if (self.presentBusinessCard) {
        self.presentBusinessCard(image);
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"%@",image);
    
}
@end
