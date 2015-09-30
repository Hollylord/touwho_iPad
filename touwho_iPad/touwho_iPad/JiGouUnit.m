//
//  JiGouUnit.m
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "JiGouUnit.h"

@implementation JiGouUnit

- (void)setModel:(ModelForJiGouUnit *)model {
    if (_model != model) {
        _model = model;
    }
    
    self.IMGView.image = model.image;
    self.label1.text = model.title1;
    self.label2.text = model.time;
    self.label3.text = model.title2;
}

@end
