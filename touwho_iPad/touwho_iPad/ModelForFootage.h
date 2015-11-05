//
//  ModelForFootage.h
//  touwho_iPad
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForFootage : NSObject
///视频id
@property (copy,nonatomic) NSString *mID;
///视频创建时间
@property (copy,nonatomic) NSString *mCreateTime;
///视频url
@property (copy,nonatomic) NSString *mVideoUrl;
///视频名称
@property (copy,nonatomic) NSString *mName;
///视频顺序
@property (copy,nonatomic) NSString *mOrder;
///视频状态
@property (copy,nonatomic) NSString *mStatus;
///ios使用的视频id
@property (copy,nonatomic) NSString *mVID;
@end
