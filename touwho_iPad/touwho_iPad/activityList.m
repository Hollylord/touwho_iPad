//
//  activityList.m
//  touwho_iPad
//
//  Created by apple on 15/9/15.
//  Copyright © 2015年 touhu.com. All rights reserved.
//
#define MarginSide 30
#define MarginTop 30
#define Width 400
#define Height 150

#import "activityList.h"
#import "activityUnit.h"
#import "ModelForActivity.h"


@implementation activityList
{
    UIScrollView *scrollView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scrollView = scroll;
        [self addSubview:scrollView];
        //scrollview中内含有滚动条，也会占到它的subview中
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        //添加数据
        ModelForActivity *model = [[ModelForActivity alloc] init];
        model.status = YES;
        model.icon = [UIImage imageNamed:@"gongdian"];
        model.name = @"独角兽项目路演";
        model.time = @"2015-8-27";
        model.introduction = @"投壶网首次线下项目路演活动，诚邀您参加！";
        
        for (int i = 0; i < 5; i ++) {
            activityUnit *view = [[[NSBundle mainBundle] loadNibNamed:@"activityUnit" owner:nil options:nil] firstObject];
            //传递数据
            view.model = model;
            //只能在self的基础上添加，不能在self的子视图上添加子控件
            [scrollView addSubview:view];
        }
    }
    return  self;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    //给scrollView添加约束
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [scrollView.superview addConstraints:@[leading,trailing,top,bottom]];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //给JiGouUnit添加约束
    for (int i = 0 ; i < scrollView.subviews.count; i ++) {
        UIView *view = scrollView.subviews[i];
        int column = i % 2;//列数
        int line = (int) i / 2;//行数
        
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant: MarginSide + column * (MarginSide + Width)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:MarginTop + line *(MarginTop + Height)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        
        [view.superview addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    //设置scrollview的滚动范围
    UIView *view = scrollView.subviews.lastObject;
    NSLayoutConstraint *trailing2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    NSLayoutConstraint *bottom2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[trailing2,bottom2]];
    
    
}


@end
