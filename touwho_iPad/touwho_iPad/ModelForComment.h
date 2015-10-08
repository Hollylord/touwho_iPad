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
@property (strong,nonatomic) ModelForUser *user;
@property (copy,nonatomic) NSString *content;
@property (copy,nonatomic) NSString *time;
@end
