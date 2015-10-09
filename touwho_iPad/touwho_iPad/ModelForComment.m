//
//  ModelForComment.m
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "ModelForComment.h"

@implementation ModelForComment
- (ModelForUser *)user{
    if (!_user) {
        _user = [[ModelForUser alloc]init];
    }
    return _user;
}
@end
