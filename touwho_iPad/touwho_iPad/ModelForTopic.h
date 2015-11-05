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
@property (copy,nonatomic) NSString *mCreateTime;
@property (copy,nonatomic) NSString *mDestribel;
@property (copy,nonatomic) NSString *mIsHot;
@property (copy,nonatomic) NSString *mGroupName;

@end
