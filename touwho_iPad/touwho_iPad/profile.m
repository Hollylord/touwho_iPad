//
//  profile.m
//  touwho_iPad
//
//  Created by apple on 15/9/16.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "profile.h"
#import "BTPickerViewController.h"


@implementation profile


- (void)awakeFromNib{
    self.scrollView.delaysContentTouches = NO;
    
    //显示名片
    if (!self.businessCard.image) {
        //cache文件夹目录
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        //拼接文件目录
        NSString *filePath = [cachePath stringByAppendingPathComponent:@"businessCard"];
        //取出图片
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:imageData];
        //显示图片
        self.businessCard.image = image;
    }
    else {
        [self.takePhotoBtn setTitle:@"重新上传" forState:UIControlStateNormal];
    }
    
    
    
}

//获得当前view的控制器
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - picker选择
- (IBAction)pickGender:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"gender" numberOfComponents:1];
    
    btPicker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    };
    
    //设置popVC的尺寸
    btPicker.preferredContentSize = CGSizeMake(300, 300);
    //设置popVC为popOver
    btPicker.modalPresentationStyle = UIModalPresentationPopover;
    //设置箭头方向
    btPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置参考系
    btPicker.popoverPresentationController.sourceView = sender;
    //设置箭头指向的对象
    btPicker.popoverPresentationController.sourceRect = sender.bounds;
    //展现popVC
    [[self viewController] presentViewController:btPicker animated:YES completion:NULL];
}

//所处行业
- (IBAction)pickIndustry:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"industry" numberOfComponents:1];
    
    btPicker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    };
    
    //设置popVC的尺寸
    btPicker.preferredContentSize = CGSizeMake(300, 300);
    //设置popVC为popOver
    btPicker.modalPresentationStyle = UIModalPresentationPopover;
    //设置箭头方向
    btPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置参考系
    btPicker.popoverPresentationController.sourceView = sender;
    //设置箭头指向的对象
    btPicker.popoverPresentationController.sourceRect = sender.bounds;
    //展现popVC
    [[self viewController] presentViewController:btPicker animated:YES completion:NULL];
}
//年龄选择
- (IBAction)pickAge:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"age" numberOfComponents:1];
    
    btPicker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    };
    
    //设置popVC的尺寸
    btPicker.preferredContentSize = CGSizeMake(300, 300);
    //设置popVC为popOver
    btPicker.modalPresentationStyle = UIModalPresentationPopover;
    //设置箭头方向
    btPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置参考系
    btPicker.popoverPresentationController.sourceView = sender;
    //设置箭头指向的对象
    btPicker.popoverPresentationController.sourceRect = sender.bounds;
    //展现popVC
    [[self viewController] presentViewController:btPicker animated:YES completion:NULL];
}
//感兴趣的行业
- (IBAction)pickInterestingIndustry:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"interestIndustry" numberOfComponents:1];
    
    btPicker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    };
    
    //设置popVC的尺寸
    btPicker.preferredContentSize = CGSizeMake(300, 300);
    //设置popVC为popOver
    btPicker.modalPresentationStyle = UIModalPresentationPopover;
    //设置箭头方向
    btPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置参考系
    btPicker.popoverPresentationController.sourceView = sender;
    //设置箭头指向的对象
    btPicker.popoverPresentationController.sourceRect = sender.bounds;
    //展现popVC
    [[self viewController] presentViewController:btPicker animated:YES completion:NULL];
}
//风险偏好
- (IBAction)pickRiskPreference:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"riskPreference" numberOfComponents:1];
    
    btPicker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    };
    
    //设置popVC的尺寸
    btPicker.preferredContentSize = CGSizeMake(300, 300);
    //设置popVC为popOver
    btPicker.modalPresentationStyle = UIModalPresentationPopover;
    //设置箭头方向
    btPicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置参考系
    btPicker.popoverPresentationController.sourceView = sender;
    //设置箭头指向的对象
    btPicker.popoverPresentationController.sourceRect = sender.bounds;
    //展现popVC
    [[self viewController] presentViewController:btPicker animated:YES completion:NULL];
}

#pragma mark - 上传个人信息
- (IBAction)saveInforToServer:(UIButton *)sender {
    NSString *sex = [self.sexBtn.titleLabel.text isEqualToString:@"女士"]?@"1":@"2";
    NSString *name = self.trueNameView.text;
    NSString *phone = self.phoneNumberView.text;
    NSString *identiCode = self.IDView.text;
    NSString *nickName = self.nickNameView.text;
    NSString *email = self.eMailVIew.text;
    NSString *atIndustry = self.atIndustry.titleLabel.text;
    NSString *age = self.age.titleLabel.text;
    NSString *interestingIndus = self.interestingIndustry.titleLabel.text;
    NSString *risk = self.riskPereference.titleLabel.text;
    //判断输入信息是否填完整
    NSArray *results = [NSArray arrayWithObjects:sex,name,phone,identiCode,email,atIndustry,age,interestingIndus,risk, nil];
    __block BOOL isInfoFull;
    [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqualToString:@""]) {
            [BTIndicator showTextOnView:self withText:@"请填写完整信息" withDelay:0.5];
            isInfoFull = NO;
            *stop = YES;
        }
    

    }];
    
    if (!isInfoFull) {
        return ;
    }
    
    //参数
    NSDictionary *para = @{@"method":@"setMyInfo",@"user_id":USER_ID,@"sex":sex,@"name":name,@"phone":phone,@"id_code":identiCode,@"nick_name":nickName,@"email":email,@"industry":atIndustry,@"age":age,@"favIndustry":interestingIndus,@"fav":risk};
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    [BTNetWorkingAPI sendUserInfoToServerWith:para andBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [MBProgressHUD hideHUDForView:self animated:YES];
            
            [BTIndicator showCheckMarkOnView:self withText:@"保存用户信息成功" withDelay:0.5];
        }
        else{
            [MBProgressHUD hideHUDForView:self animated:YES];
            
            [BTIndicator showForkMarkOnView:self withText:@"保存用户信息失败" withDelay:0.5];
        }
    }];
   
    
    
}



@end
