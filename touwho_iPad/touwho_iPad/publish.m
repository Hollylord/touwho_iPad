//
//  publish.m
//  touwho_iPad
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "publish.h"


@implementation publish

//行业选择
- (IBAction)chooseIndustry:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"firms" numberOfComponents:2];
    
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
- (IBAction)regionPick:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"area" numberOfComponents:3];
    
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

//项目状态选择
- (IBAction)statePick:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"stateOfProgram" numberOfComponents:1];
    
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

#pragma mark - 上传数据
- (IBAction)sendInfoToServer:(UIButton *)sender {
    NSString *companyName = self.companyName.text;
    NSString *industry = self.industry.titleLabel.text;
    NSString *programName = self.programName.text;
    NSString *amount = self.amount.text;
    NSString *place = self.place.titleLabel.text;
    NSString *programStatus = self.programStatus.titleLabel.text;
    NSString *introduction = self.introduction.text;
    
    //参数
    NSDictionary *para = @{@"method":@"addProject",@"user_id":USER_ID,@"company":companyName,@"industry_name":industry,@"project_name":programName,@"goal_money":amount,@"province":place,@"invest_step":programStatus,@"destrible":introduction};
    
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"申请已提交！";
        [hud hide:YES afterDelay:1];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

@end
