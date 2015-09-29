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
    self.picker = [[BTPickerViewController alloc] initWithPlist:@"industry" numberOfComponents:1];
    
    self.picker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
    };
    
    //设置popVC的尺寸
    self.picker.preferredContentSize = CGSizeMake(300, 300);
    //设置popVC为popOver
    self.picker.modalPresentationStyle = UIModalPresentationPopover;
    //设置箭头方向
    self.picker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置参考系
    self.picker.popoverPresentationController.sourceView = sender;
    //设置箭头指向的对象
    self.picker.popoverPresentationController.sourceRect = sender.bounds;
    //展现popVC
    [[self viewController] presentViewController:self.picker animated:YES completion:NULL];
    
    
}
- (IBAction)regionPick:(UIButton *)sender {
    //创建popVC
    self.picker = [[BTPickerViewController alloc] initWithPlist:@"area" numberOfComponents:3];
    
    self.picker.regionPickerBlock = ^(NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
    };
    
    //设置popVC的尺寸
    self.picker.preferredContentSize = CGSizeMake(300, 300);
    //设置popVC为popOver
    self.picker.modalPresentationStyle = UIModalPresentationPopover;
    //设置箭头方向
    self.picker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置参考系
    self.picker.popoverPresentationController.sourceView = sender;
    //设置箭头指向的对象
    self.picker.popoverPresentationController.sourceRect = sender.bounds;
    //展现popVC
    [[self viewController] presentViewController:self.picker animated:YES completion:NULL];
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
