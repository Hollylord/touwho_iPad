//
//  ModelForUser.h
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForUser : NSObject
@property (strong,nonatomic) UIImage *icon;
@property (copy,nonatomic) NSString *nickName;
@property (copy,nonatomic) NSString *iconURL;
@property (copy,nonatomic) NSString *userID;
@property (copy,nonatomic) NSString *mEmail;
///身份证号
@property (copy,nonatomic) NSString *mIDCardCode;
///个人简介
@property (copy,nonatomic) NSString *mIntro;
///是否为领投人GP
@property (copy,nonatomic) NSString *mIsFirstInvestor;
///是否为跟头人LP
@property (copy,nonatomic) NSString *mIsInvestor;
///真是姓名
@property (copy,nonatomic) NSString *mName;
///手机号
@property (copy,nonatomic) NSString *mPhone;
///性别
@property (copy,nonatomic) NSString *mSex;
///用户账号
@property (copy,nonatomic) NSString *mAccount;
///类型（保留）
@property (copy,nonatomic) NSString *mType;
@end
