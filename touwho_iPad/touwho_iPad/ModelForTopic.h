//
//  ModelForTopic.h
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelForUser.h"
#import "ModelForGroup.h"

@interface ModelForTopic : NSObject

@property (strong,nonatomic) ModelForUser *publisher;
@property (strong,nonatomic) ModelForGroup *group;

///话题的logo
@property (copy,nonatomic) NSString *mLogo;
///话题的名称
@property (copy,nonatomic) NSString *mTitle;
///话题缩写
@property (copy,nonatomic) NSString *mShortTitle;
///话题创建时间
@property (copy,nonatomic) NSString *mCreateTime;
///话题简介
@property (copy,nonatomic) NSString *mDestrible;
///是否为热门话题
@property (copy,nonatomic) NSString *mIsHot;
///小组的名字
@property (copy,nonatomic) NSString *mGroupName;
///话题id
@property (copy,nonatomic) NSString *mID;

@end
