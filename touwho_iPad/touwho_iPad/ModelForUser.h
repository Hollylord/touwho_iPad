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
///昵称
@property (copy,nonatomic) NSString *mNickName;
///头像url
@property (copy,nonatomic) NSString *mAvatar;
///用户id
@property (copy,nonatomic) NSString *mID;

///身份证号
@property (copy,nonatomic) NSString *mIDCardCode;
///个人简介
@property (copy,nonatomic) NSString *mIntro;
///用户账号
@property (copy,nonatomic) NSString *mAccount;
///类型（保留）
@property (copy,nonatomic) NSString *mType;
///名片的url
@property (copy,nonatomic) NSString *mCardUrl;
///个人投资理念
@property (copy,nonatomic) NSString *mDes;

#pragma mark - 必填
///真实姓名
@property (copy,nonatomic) NSString *mName;
///手机号
@property (copy,nonatomic) NSString *mPhone;
///性别
@property (copy,nonatomic) NSString *mSex;

@property (copy,nonatomic) NSString *mAge;

@property (copy,nonatomic) NSString *mEmail;
///风险偏好
@property (copy,nonatomic) NSString *mFav;
///感兴趣的行业
@property (copy,nonatomic) NSString *mFavIndustry;
///所处行业
@property (copy,nonatomic) NSString *mIndustry;

@end
