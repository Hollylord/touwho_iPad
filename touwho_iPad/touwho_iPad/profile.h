//
//  profile.h
//  touwho_iPad
//
//  Created by apple on 15/9/16.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profile : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

///名片照片
@property (weak, nonatomic) IBOutlet UIImageView *businessCard;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UITextField *nickNameView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberView;
///身份证号
@property (weak, nonatomic) IBOutlet UITextField *IDView;
@property (weak, nonatomic) IBOutlet UITextField *trueNameView;
@property (weak, nonatomic) IBOutlet UITextField *eMailVIew;
///所处的行业
@property (weak, nonatomic) IBOutlet UIButton *atIndustry;
@property (weak, nonatomic) IBOutlet UIButton *age;
///感兴趣的行业
@property (weak, nonatomic) IBOutlet UIButton *interestingIndustry;
///风险偏好
@property (weak, nonatomic) IBOutlet UIButton *riskPereference;



@end
