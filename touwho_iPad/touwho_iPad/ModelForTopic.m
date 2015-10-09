//
//  ModelForTopic.m
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "ModelForTopic.h"

@implementation ModelForTopic
- (ModelForUser *)publisher{
    if (!_publisher) {
        _publisher = [[ModelForUser alloc] init];
    }
    return _publisher;
}
- (ModelForGroup *)group{
    if (!_group) {
        _group = [[ModelForGroup alloc] init];
    }
    return _group;
}
@end
