//
//  ModelTopicDetail.h
//  touwho_iPad
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelTopicDetail : NSObject
///话题id
@property (copy,nonatomic) NSString *mID;

///是否点赞 0未点赞 1已点赞
@property (copy,nonatomic) NSString *mIsPraise;
///点赞数
@property (copy,nonatomic) NSString *mPraiseCount;
///话题评论列表
@property (strong,nonatomic) NSMutableArray *mTalkComments;
///话题内容
@property (copy,nonatomic) NSString *mTalkContent;
///所属小组id
@property (copy,nonatomic) NSString *mGroupID;
@end
