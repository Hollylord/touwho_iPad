//
//  ModelForGroup.h
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForGroup : NSObject
@property (strong,nonatomic) UIImage *icon;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *introduction;
//存放话题列表
@property (strong,nonatomic) NSMutableArray *topicArr;
@end
