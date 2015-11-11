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
#import "UIImage+UIimage_HeadIcon.h"
#import "SettingViewController.h"

@interface profileViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet meLeft *meLeftView;
@property (strong,nonatomic) UIView *meRightView;
//导航栏
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;



@end

@implementation profileViewController
- (ModelForUser *)model{
    if (!_model) {
        _model = [[ModelForUser alloc] init];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    self.model.mNickName = [user objectForKey:@"userName"];
    self.model.mID = [user objectForKey:@"userID"];
    NSString *iconUrl = [NSString stringWithFormat:@"%@%@",SERVER_URL,[user objectForKey:@"iconURL"]];
    self.model.mAvatar = iconUrl;
    
    //添加左边view
    meLeft *me         = [[[NSBundle mainBundle] loadNibNamed:@"meLeft" owner:self options:nil]firstObject];
    //传数据
    me.model = self.model;
    [self.view addSubview:me];
    [self layoutForMe:me];
    
    //modal出头像控制器
    me.headClick = ^(){
        HeadIconViewController *headVC = [[HeadIconViewController alloc] initWithNibName:@"HeadIconViewController" bundle:nil];
        headVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:headVC animated:YES completion:^{
            
            //获得头像后显示出来
            headVC.passImage = ^(UIImage *image){
                meLeft *view = self.view.subviews[1];
                UIImage *newImage = [UIImage imageClipsWithHeadIcon:image sideWidth:0];
                view.headImageView.image = newImage;
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
    NSLayoutConstraint *top     = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:1];
    NSLayoutConstraint *bottom  = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width   = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    
    [self.view addConstraints:@[leading,top,bottom]];
    [view addConstraint:width];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view layoutIfNeeded];
    
}

- (void)layoutForMeRight:(UIView *)view{
    
    NSLayoutConstraint *top      = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64];
    NSLayoutConstraint *bottom   = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width    = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:923-300];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    [self.view addConstraints:@[trailing,top,bottom]];
    [view addConstraint:width];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view layoutIfNeeded];
    
  
}


#pragma mark - 按钮点击
//上传名片
- (IBAction)uploadCard:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"上传名片"]) {
        [sender setTitle:@"重新上传" forState:UIControlStateNormal];//修改按钮的文字
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
    
}

//设置
- (IBAction)setting:(UIBarButtonItem *)sender {
    SettingViewController *setVC = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:setVC];
    navi.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navi animated:YES completion:NULL];
}

#pragma mark - 照相机代理
//拍照完毕后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //退出照相机
    [picker dismissViewControllerAnimated:YES completion:NULL];
    //获取原始图片
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    NSDictionary *temp = [info objectForKey:@"UIImagePickerControllerMediaMetadata"];
    int orientation = (int)[temp objectForKey:@"Orientation"];
    //如果照相方向反了就把图片旋转180°
    if (orientation == 50) {
        //旋转图片
        //获得上下文
        UIGraphicsBeginImageContext(image.size);
        
        //往上下文上添加图片 自适应坐标系
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //获得新图片 新图片的坐标系变换了
        UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();        UIGraphicsEndImageContext();
        image = imageNew;
    }
    
    
    //将拍得的照片显示到个人信息页面上的名片上
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
