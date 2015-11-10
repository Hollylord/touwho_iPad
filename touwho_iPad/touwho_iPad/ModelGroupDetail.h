//
//  ModelGroupDetail.h
//  touwho_iPad
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelGroupDetail : NSObject
///创建时间
@property (copy,nonatomic) NSString *mCreateTime;
///小组简介
@property (copy,nonatomic) NSString *mDestrible;
///小组组长
@property (copy,nonatomic) NSString *mGroupLeader;
///小组ID
@property (copy,nonatomic) NSString *mID;
///小组是否热门
@property (copy,nonatomic) NSString *mIsHot;
///小组logo
@property (copy,nonatomic) NSString *mLogo;
///小组人数
@property (copy,nonatomic) NSString *mMemberCount;
///小组名字
@property (copy,nonatomic) NSString *mName;
///小组顺序
@property (copy,nonatomic) NSString *mOrder;
///小组状态
@property (copy,nonatomic) NSString *mStatus;
///所有话题
@property (strong,nonatomic) NSMutableArray *mTalks;
@end
