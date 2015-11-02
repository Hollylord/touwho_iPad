//
//  ModelProgramDetails.h
//  touwho_iPad
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelProgramDetails : NSObject
//领投人列表 GP
@property (strong,nonatomic) NSMutableArray *mFirstInvestor;
//跟投人列表 LP
@property (strong,nonatomic) NSMutableArray *mFollowInvestor;
//发起人列表
@property (strong,nonatomic) NSMutableArray *mLeaderInvestor;
//二维码url
@property (copy,nonatomic) NSString *mQRUrl;
//是否关注项目
@property (copy,nonatomic) NSString *mFollowStatus;

//项目详情
@property (copy,nonatomic) NSString *mSummary;
//投资建议
@property (copy,nonatomic) NSString *mSuggest;
//融资方案
@property (copy,nonatomic) NSString *mScheme;
//视频url
@property (copy,nonatomic) NSString *mVideo;

@end
