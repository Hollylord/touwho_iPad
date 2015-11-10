//
//  BTNetWorking.h
//  touwho_iPad
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
