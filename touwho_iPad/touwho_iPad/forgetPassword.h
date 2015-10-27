//
//  forgetPassword.h
//  touwho_iPad

//  Created by apple on 15/9/7.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgetPassword : UIView
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberView;
@property (weak, nonatomic) IBOutlet UITextField *vercodeInputView;
@property (weak, nonatomic) IBOutlet UIButton *vercodeBtn;




- (IBAction)upStep:(UIButton *)sender;
@end
