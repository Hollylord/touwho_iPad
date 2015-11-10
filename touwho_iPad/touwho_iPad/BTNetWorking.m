//
//  BTNetWorking.m
//  touwho_iPad
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "BTNetWorking.h"



@implementation BTNetWorking

+ (void)getDataWithPara:(NSDictionary *)para success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failure(operation,error);
    }];
}

+ (id)getUserInfoWithKey:(NSString *)key{
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    id value = [user objectForKey:key];
    return value;
}

+ (void)analyzeResponseObject:(id)responseObject andCompletionBlock:(completion)block{
    NSArray *value = [responseObject objectForKey:@"value"];
    NSDictionary *result = [value firstObject];
    NSArray *jsonArr = [result objectForKey:@"jsonArr"];
    NSString *resCode = [result objectForKey:@"resCode"];
    
    block(jsonArr,resCode);
}

+ (CGFloat)calcutateHeightForTextviewWithFont:(UIFont *)font andContent:(NSString *)content andWidth:(CGFloat)width{

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    NSStringDrawingOptions opts = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:opts attributes:attribute context:nil].size;
    return textSize.height + font.lineHeight;
}

@end
