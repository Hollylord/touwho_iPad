//
//  WDMessageModel.h
//  SuperPhoto
//
//  Created by 222ying on 15/7/14.
//  Copyright (c) 2015年 222ying. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    msgMe = 0,  //me
    msgrobot  //robot
    
}MessageModelType;


@interface WDMessageModel : NSObject
//显示正文
@property (nonatomic , copy) NSString * text;
//时间
@property (nonatomic , copy) NSString *time;
// 图片地址
//@property (nonatomic , copy) NSString *image;
// 发送类型
@property (nonatomic , assign) MessageModelType type;



// 是否可隐藏时间
@property (nonatomic ,assign) BOOL hideTime;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)messageWithDict:(NSDictionary *) dict;

+(NSArray *)message;
@end
