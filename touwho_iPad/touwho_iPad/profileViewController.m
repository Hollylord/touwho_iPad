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
#import "HeadIconViewController.h"

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
    
    //modal出头像控制器

    me.headClick = ^(){
        HeadIconViewController *headVC = [[HeadIconViewController alloc] initWithNibName:@"HeadIconViewController" bundle:nil];
        headVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:headVC animated:YES completion:^{
            
            //获得头像后显示出来
            headVC.passImage = ^(UIImage *image){
                meLeft *view = self.view.subviews[0];
                view.headImageView.image = image;
            };
        }];
        
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
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"上传名片"]) {
        [sender setTitle:@"重新上传" forState:UIControlStateNormal];//修改按钮的文字
    }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
    
    
    
}

#pragma mark - 照相机代理
//拍照完毕后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:NULL];//退出照相机
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取原始图片
    NSDictionary *temp = [info objectForKey:@"UIImagePickerControllerMediaMetadata"];
    int orientation = (int)[temp objectForKey:@"Orientation"];
    //如果照相方向反了就把图片旋转180°
    if (orientation == 50) {
        //旋转图片
        //获得上下文
        UIGraphicsBeginImageContext(image.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        //往上下文上添加图片
        CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
        CGContextRotateCTM(context, M_PI);//旋转
        UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();//获得新图片
        UIGraphicsEndImageContext();
        image = imageNew;
    }
    
    
    //将拍得的照片显示到个人信息页面上
    if (self.presentBusinessCard) {
        self.presentBusinessCard(image);
    }
    
    //cache文件夹目录
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //拼接文件目录
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"businessCard"];
    //图片转NSData
    NSData * imageData = UIImagePNGRepresentation(image);
    //保存图片
    [imageData writeToFile:filePath atomically:YES];
    
    
}

@end
