//
//  ModelForActivity.h
//  touwho_iPad
//
//  Created by apple on 15/10/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForActivity : NSObject
///活动状态
@property (copy,nonatomic) NSString *mStatus;
///活动id
@property (copy,nonatomic) NSString *mID;
///活动标题
@property (copy,nonatomic) NSString *mTitle;
///活动地址
@property (copy,nonatomic) NSString *mAddress;
///活动时间
@property (copy,nonatomic) NSString *mTime;
///简介
@property (copy,nonatomic) NSString *introduction;
@end
