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

#import "HeadIconViewController.h"
#import "UIImage+UIimage_HeadIcon.h"
#import "SettingViewController.h"
#import <AVOSCloudIM.h>
#import "ModelChating.h"
#import "LeanMessageManager.h"

@interface profileViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVIMClientDelegate>

@property (strong, nonatomic) IBOutlet meLeft *meLeftView;
@property (strong,nonatomic) meRight *meRightView;
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
    NSManagedObject *person = [BTNetWorking withDrawPersonInfoFromDatabase];
    NSString *nickName = [person valueForKey:@"nickName"];
    if ([nickName isEqualToString:@""]||nickName == nil) {
        self.model.mNickName = [user objectForKey:@"userName"];
    }
    else {
        self.model.mNickName = nickName;
    }
    
    self.model.mID = USER_ID;
    if ([BTNetWorking isTheStringContainedHttpWithString:[user objectForKey:@"iconURL"]]) {
        self.model.mAvatar = [user objectForKey:@"iconURL"];
    }
    else{
        NSString *iconUrl = [NSString stringWithFormat:@"%@%@",SERVER_URL,[user objectForKey:@"iconURL"]];
        self.model.mAvatar = iconUrl;
    }
    
    
    
    //添加左边view
    meLeft *me         = [[[NSBundle mainBundle] loadNibNamed:@"meLeft" owner:self options:nil]firstObject];
    //传数据
    me.model = self.model;
    [self.view addSubview:me];
    [self layoutForMe:me];
    
    //modal出更换头像控制器
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
    
    //建立与leanCloud的长连接
    [self buildConnectWithLeanCloud];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [TalkingData trackPageBegin:@"个人中心页"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"个人中心页"];
}

#pragma mark - 建立LeanCloud
- (void)buildConnectWithLeanCloud{
    LeanMessageManager *mgr = [LeanMessageManager manager];
    [mgr openSessionWithClientID:USER_ID completion:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"%@",error);
            [self buildConnectWithLeanCloud];
            
        }
        else{
            //查询会话
            [mgr findRecentConversationsWithBlock:^(NSArray *objects, NSError *error) {
                //会话转models
                [self updateConversations:objects];
                
            }];

        }
        
    }];
    

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


#pragma mark 名片拍照
- (IBAction)uploadCard:(UIButton *)sender {
    [TalkingData trackEvent:@"上传名片"];
    
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

#pragma mark 点击设置
- (IBAction)setting:(UIBarButtonItem *)sender {
    [TalkingData trackEvent:@"点击设置"];
    
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
    NSData * imageData = UIImageJPEGRepresentation(image, 1);
    //保存图片
    [imageData writeToFile:filePath atomically:YES];
    //上传给服务器
    [self sendPostCardToServer:imageData];
    
}

#pragma mark - 上传图片
- (void) sendPostCardToServer:(NSData *)data{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [mgr.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *para = @{@"method":@"uploadCard",@"user_id":USER_ID};
    
    [mgr POST:SERVER_API_URL parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传数据 必须指明mimeType
        //name是：服务器收到的文件名字
        [formData appendPartWithFileData:data name:@"postCard" fileName:@"postCard" mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Checkmark"]];
        hud.labelText = @"上传名片成功";
        [hud hide:YES afterDelay:0.5];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - LeanCloud代理


- (void) updateConversations:(NSArray *)conversations{
    
    NSMutableArray *models = [NSMutableArray array];
    
    //数组转models
    for (AVIMConversation *obj in conversations) {
        ModelChating *model = [[ModelChating alloc] init];
        model.name = obj.name;
        model.members = obj.members;
        model.lastMessageAt = obj.lastMessageAt;
        [models addObject:model];
    }
    
    
    if (self.didReceiveBlock) {
        self.didReceiveBlock(models);
    }
    else{
        self.meRightView.conversations = models;
    }
}
@end
