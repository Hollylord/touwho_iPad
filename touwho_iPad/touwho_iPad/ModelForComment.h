//
//  ModelForComment.h
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelForUser.h"

@interface ModelForComment : NSObject

///评论的内容
@property (copy,nonatomic) NSString *mTalkContent;
///评论的时间
@property (copy,nonatomic) NSString *mCreateTime;
///评论者的头像
@property (copy,nonatomic) NSString *mAvatar;
///评论人的昵称
@property (copy,nonatomic) NSString *mNickName;
///该评论是否点赞 0未点赞 1已点赞
@property (copy,nonatomic) NSString *mIsPraise;
///评论点赞人数
@property (copy,nonatomic) NSString *mTalkCommentPraizeCount;
///评论id
@property (copy,nonatomic) NSString *mTalkCommentID;
///评论人的userID
@property (copy,nonatomic) NSString *mUserID;
@end
