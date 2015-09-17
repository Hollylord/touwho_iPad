//
//  profile.m
//  touwho_iPad
//
//  Created by apple on 15/9/16.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "profile.h"


@implementation profile


- (void)awakeFromNib{
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"sex"];
    BOOL status = [[NSUserDefaults standardUserDefaults] boolForKey:@"genderSwitchisOn"];
    if (str) {
        self.gender.text = str;
        self.genderSwitch.on = status;
    }
    
    
    
    //显示名片
    if (!self.businessCard.image) {
        [self.takePhotoBtn setTitle:@"重新上传" forState:UIControlStateNormal];
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
        [self.takePhotoBtn setTitle:@"上传名片" forState:UIControlStateNormal];
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
#pragma mark - UISwitch响应
- (IBAction)sexChoose:(UISwitch *)sender {
    if ([sender isOn]) {
        self.gender.text = @"先生";
    }
    else{
        self.gender.text = @"女士";
    }
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"genderSwitchisOn"];
    [[NSUserDefaults standardUserDefaults] setValue:self.gender.text forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
