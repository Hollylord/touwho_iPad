//
//  circle.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "circle.h"

@implementation circle
- (NSMutableArray *)views{
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}
//可以创建子视图
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //添加小组到数组中
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"xiaozu" owner:nil options:nil]firstObject];
        [self.views addObject:view];
       
        UIView *view2 = [[[NSBundle mainBundle] loadNibNamed:@"topics" owner:nil options:nil]firstObject];
        [self.views addObject:view2];
        
        UIView *view3 = [[[NSBundle mainBundle] loadNibNamed:@"sixin" owner:nil options:nil]firstObject];
        [self.views addObject:view3];
        
    }
    return self;
}

//设置,添加子视图一律在这个方法里面
- (void)awakeFromNib{
    [self.segement addTarget:self action:@selector(segmentValueChanged) forControlEvents:UIControlEventValueChanged];
    [self segmentValueChanged];
}

#pragma mark 布局小组，话题，私信
- (void)segmentValueChanged {
    
     //小组
    if (self.segement.selectedSegmentIndex == 0) {
        [self.views[1] removeFromSuperview];
        [self.views[2] removeFromSuperview];

        UIView *view = self.views[0];
        [self addSubview:view];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:64];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:@[leading,trailing,top,bottom]];
    }
    //    最新话题
    else if (self.segement.selectedSegmentIndex == 1)
    {
        [self.views[0] removeFromSuperview];
        [self.views[2] removeFromSuperview];
        
        UIView *view = self.views[1];
        [self addSubview:view];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:64];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:@[leading,trailing,top,bottom]];
    }
    //私信
    else{
        [self.views[0] removeFromSuperview];
        [self.views[1] removeFromSuperview];
        
        UIView *view = self.views[2];
        [self addSubview:view];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:64];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:@[leading,trailing,top,bottom]];
    }
    
}
@end
