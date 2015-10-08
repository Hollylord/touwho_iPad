//
//  ModelForTopic.h
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelForUser.h"

@interface ModelForTopic : NSObject

@property (strong,nonatomic) ModelForUser *publisher;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *content;
@property (copy,nonatomic) NSString *time;
//存放所有评论
@property (strong,nonatomic) NSMutableArray *commentArr;
@end
