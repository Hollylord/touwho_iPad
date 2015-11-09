//
//  HeadIconViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/17.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "HeadIconViewController.h"
#import "MyImagePickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface HeadIconViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

- (IBAction)cancelClick:(UIBarButtonItem *)sender;
- (IBAction)localIconClick:(UIButton *)sender;
- (IBAction)uploadClick:(UIButton *)sender;
- (IBAction)OK:(UIBarButtonItem *)sender;

@end

@implementation HeadIconViewController
{
    UIImage *imageForHead;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    headIconPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    headIconPicker.delegate = self;
  
    headIconPicker.allowsEditing = YES;
    [self presentViewController:headIconPicker animated:YES completion:NULL];
}

//点击上传
- (IBAction)uploadClick:(UIButton *)sender {
    
}

//点击确定
- (IBAction)OK:(UIBarButtonItem *)sender {
    if (!imageForHead) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        return ;
    }
    
    //传递图片给个人中心left的头像
    if (self.passImage) {
        self.passImage(imageForHead);
    }
    
    //传头像给左菜单的头像
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setHeadImageView" object:self userInfo:@{@"headIcon":imageForHead}];
    
    //上传头像给服务器
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

    [mgr.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *para = @{@"method":@"alterAvatar",@"user_id":USER_ID};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    

    [mgr POST:SERVER_API_URL parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *compressed = UIImageJPEGRepresentation(imageForHead, 0.5);
        //上传数据 必须指明mimeType
        //name是：服务器收到的文件名字
        [formData appendPartWithFileData:compressed name:@"123" fileName:@"headImage" mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *icon = [[[responseObject objectForKey:@"value"] firstObject] objectForKey:@"resValue"];
        
        //nsuserDefaults 不支持NSMutableDictionary
        NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        NSMutableDictionary *user2 = [[NSMutableDictionary alloc] initWithDictionary:user];
        [user2 setValue:icon forKey:@"iconURL"];
        [[NSUserDefaults standardUserDefaults] setObject:user2 forKey:@"user"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark - UIImagePicker代理
//点击use photo后的回调方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //退出照相机
    [picker dismissViewControllerAnimated:YES completion:NULL];
    //获得原图
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //显示图片在imageView上
    self.headImage.image = image;
    imageForHead = image;
    
    //图片压缩成NSData 可以适合上传
    NSData *compressed = UIImageJPEGRepresentation(image, 0.5);
    //存储图片
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cache stringByAppendingPathComponent:@"headIcon"];
    [compressed writeToFile:filePath atomically:YES];
    
}

@end
