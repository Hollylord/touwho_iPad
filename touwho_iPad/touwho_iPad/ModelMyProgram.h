//
//  ModelMyProgram.h
//  touwho_iPad
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelMyProgram : NSObject
///公司名称
@property (copy,nonatomic) NSString *mCompanyName;
///项目目前融资金额
@property (copy,nonatomic) NSString *mCurMoney;
///项目简介
@property (copy,nonatomic) NSString *mDestrible;
///是否关注此项目
@property (copy,nonatomic) NSString *mFollowStatus;
///大图url
@property (copy,nonatomic) NSString *mFullImageUrl;
///目标总金额
@property (copy,nonatomic) NSString *mGoalMoney;
///项目id
@property (copy,nonatomic) NSString *mID;
///所处行业
@property (copy,nonatomic) NSString *mIndustryName;
///投资阶段
@property (copy,nonatomic) NSString *mInvestStep;
///项目地点
@property (copy,nonatomic) NSString *mProvince;
///项目小图
@property (copy,nonatomic) NSString *mSmallImageUrl;
///项目状态0等待审核 1预热中D 2正在进行 3已结束
@property (copy,nonatomic) NSString *mStatus;
///项目名称
@property (copy,nonatomic) NSString *mTitle;
///项目类型
@property (copy,nonatomic) NSString *mType;

@end
