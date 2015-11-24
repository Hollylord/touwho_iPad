//
//  apply.m
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "apply.h"
#import "BTPickerViewController.h"
#import "ModelForUser.h"

@implementation apply
{
    //暂时保存企业类型
    NSString *industryType;
}
- (void)awakeFromNib{
    self.scrollView.delaysContentTouches = NO;
}

- (IBAction)enterprisePick:(UIButton *)sender {
    //创建popVC
    BTPickerViewController *btPicker = [[BTPickerViewController alloc] initWithPlist:@"enterprise" numberOfComponents:3];
    
    btPicker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        industryType = title;
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

#pragma  mark - 申请
- (IBAction)sendInfoToServer:(UIButton *)sender {
   
    
    //0 判断个人信息是否完善
    __block BOOL isPersonalInfoFul;
    [BTNetWorkingAPI pullUserInfoFromServerWith:USER_ID andBlock:^(ModelForUser *user) {
        NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:user.mSex,user.mPhone,user.mName,user.mEmail,user.mIndustry,user.mAge,user.mFavIndustry,user.mFav, nil];
        
        for (NSString *str in temp) {
            if ([str isEqualToString:@""] ) {
                //提示提交完整信息
                [BTIndicator showForkMarkOnView:self withText:@"请提交完整个人信息" withDelay:1];
                isPersonalInfoFul = NO;
            }
        }
        
        isPersonalInfoFul = YES;
    }];
    
    if (!isPersonalInfoFul) {
        return ;
    }
    
    //理由内容
    NSString *reason = self.reasonView.text;
    
    //1 。判断是领头的申请页面
    if (self.isLingtou) {
        //没选行业类型则提示
        if (!industryType) {
            [BTIndicator showForkMarkOnView:self withText:@"请选择行业类型" withDelay:1];
            return ;
        }
        //申请领投资格
        NSDictionary *para = @{@"method":@"applicateFirstInvestor",@"user_id":USER_ID,@"destrible":reason,@"field1":industryType};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [BTIndicator showCheckMarkOnView:self withText:@"您的审核已提交成功！" withDelay:1];
            
        } failure:NULL];
    }else{
        //申请跟投资格
        NSDictionary *para = @{@"method":@"applicateInvestor",@"user_id":USER_ID,@"destrible":reason};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Checkmark"]];
            hud.labelText = @"您的审核已提交成功！";
            [hud hide:YES afterDelay:1];
            
        } failure:NULL];
    }
    
}
@end
