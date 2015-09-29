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
@end
