//
//  xiaozuUnit.m
//  touwho_iPad
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "xiaozuUnit.h"

@implementation xiaozuUnit
- (void)setModel:(ModelForGroup *)model{
    if (_model != model) {
        _model = model;
    }
    self.iconView.image = model.icon;
}

@end
