//
//  TopicUnit.m
//  touwho_iPad
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "TopicUnit.h"

@implementation TopicUnit
- (void)setModel:(ModelForTopic *)model{
    if (_model != model) {
        _model = model;
        
    }
    self.iconView.image = model.publisher.icon;
    self.topicNameLabel.text = model.title;
    self.groupNameLabel.text = model.group.name;
    self.timeLabel.text = @"2015-10-9";
}

@end
