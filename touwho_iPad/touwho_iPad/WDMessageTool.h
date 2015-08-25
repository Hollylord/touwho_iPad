//
//  WDMessageTool.h
//  SuperPhoto
//
//  Created by 222ying on 15/7/16.
//  Copyright (c) 2015年 222ying. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WDMessageModel;

@interface WDMessageTool : NSObject

+(BOOL)addMessage:(WDMessageModel *)message; // 别人只要传一个模型给我 我就传到数据库里面去
+(BOOL)addAutoReplay:(NSDictionary *)dict;

+(NSArray *) messages;
+(NSDictionary *)autoReplay;

+(BOOL) copyMessages;
+(BOOL) copyautoReplay;
+(BOOL)addALLMessage:(NSMutableArray *)allMessage;

@end
