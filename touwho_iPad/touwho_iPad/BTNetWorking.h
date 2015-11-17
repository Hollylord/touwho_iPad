//
//  BTNetWorking.h
//  touwho_iPad
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloudIM.h>
#import "ModelForUser.h"


typedef void(^completion)(NSArray *jsonArr,NSString *resCode);
@interface BTNetWorking : NSObject

///获取网络内容
+ (void)getDataWithPara:(NSDictionary *)para success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
///获取用户信息
+ (id)getUserInfoWithKey:(NSString *)key;

///获取jsonArr
+ (void)analyzeResponseObject:(id)responseObject andCompletionBlock:(completion)block;

///根据字体和内容计算高度
+ (CGFloat)calcutateHeightForTextviewWithFont:(UIFont *)font andContent:(NSString *)content andWidth:(CGFloat)width;
///判断用户是否已登录
+ (BOOL)isUserAlreadyLoginWithAlertView:(UIView *)view;

///保存对话数据到数据库
+ (void)setupCoreDataAndSaveConversation:(AVIMConversation *)conversation;

///查询所有的对话
+ (NSArray *)withDrawAllConversationFromDatabase;


///判断是否为领投人
+ (void) isQualifiedWithUserID:(NSString *)user_id withResults:(void(^)(BOOL isFirstInvestor,BOOL isInvestor))Block;

///获取用户信息接口
+ (void)pullUserInfoFromServerWith:(NSString *)user_id andBlock:(void(^)(ModelForUser *user))block;

///上传个人信息到server接口
+ (void) sendUserInfoToServerWith:(NSDictionary *)dic andBlock:(void(^)(BOOL isSuccess))block;
@end
