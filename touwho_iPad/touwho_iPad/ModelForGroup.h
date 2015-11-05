//
//  ModelForGroup.h
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForGroup : NSObject

///小组id
@property (copy,nonatomic) NSString *mID;
///小组名称
@property (copy,nonatomic) NSString *mName;
///小组logo
@property (copy,nonatomic) NSString *mLogo;
///创建时间
@property (copy,nonatomic) NSString *mCreateTime;
///小组状态
@property (copy,nonatomic) NSString *mStatus;
///小组顺序
@property (copy,nonatomic) NSString *mOrder;
///简介
@property (copy,nonatomic) NSString *mDestrible;
///是否热门小组
@property (copy,nonatomic) NSString *mIsHot;
///组长
@property (copy,nonatomic) NSString *mGroupLeader;
///小组成员数量
@property (copy,nonatomic) NSString *mMemberCount;

@end
