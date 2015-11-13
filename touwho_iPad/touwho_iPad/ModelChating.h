//
//  ModelChating.h
//  touwho_iPad
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelChating : NSObject

@property (nonatomic, strong) NSArray      *members;        // 对话参与者列表
@property (nonatomic, strong) NSString     *name;           // 对话名字
@property (nonatomic, strong) NSDate       *lastMessageAt;  // 对话中最后一条消息的发送时间
@property (nonatomic,assign) NSInteger unread;//未读数量

@end
