//
//  shipinMenuView.m
//  touwho_iPad
//
//  Created by apple on 15/8/20.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "shipinMenuView.h"
#import "shipinView.h"
#define MarginSide 30
#define MarginTop 30
#define Width 193
#define Height 216

@implementation shipinMenuView
- (instancetype)init{
    self = [super init];
    if (self) {
        for (int i = 0; i < 5; i ++) {
            shipinView *view = [[[NSBundle mainBundle] loadNibNamed:@"shipinView" owner:nil options:nil] firstObject];
            [self addSubview:view];
        }
    }
    return  self;
}

- (void)layoutSubviews{
    for (int i = 0; i < self.subviews.count; i ++) {
        shipinView *view = self.subviews[i];
        //列数
        int column = i%4;
        //行数
        int line = (int)i/4;
        
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column * (MarginSide + Width)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:MarginTop + line * (Height + MarginTop)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:193];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:Height];
        [self addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}
@end
