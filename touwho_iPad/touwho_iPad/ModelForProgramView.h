//
//  ModelForProgramView.h
//  touwho_iPad
//
//  Created by apple on 15/9/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForProgramView : NSObject
//项目名称
@property (copy, nonatomic) NSString *mTitle;
//公司名称
@property (copy,nonatomic) NSString *mCompanyName;
//当前融资额
@property (copy, nonatomic) NSString *mCurMoney;
//目标金额
@property (copy, nonatomic) NSString *mGoalMoney;

//项目简介
@property (copy, nonatomic) NSString *mDestrible;
//是否关注
@property (copy, nonatomic) NSString *mFollowStatus;
//大图片
@property (copy, nonatomic) NSString *mFullImageUrl;
//小图片
@property (copy, nonatomic) NSString *mSmallImageUrl;

//项目id
@property (copy,nonatomic) NSString *mID;
//行业名称
@property (copy,nonatomic) NSString *mIndustryName;
//投资阶段
@property (copy,nonatomic) NSString *mInvestStep;
//城市
@property (copy,nonatomic) NSString *mProvince;
//项目类型
@property (copy,nonatomic) NSString *mType;

//@property (copy, nonatomic) NSString *totalAmount;
//@property (strong,nonatomic) UIImage *backIMG;
@end
