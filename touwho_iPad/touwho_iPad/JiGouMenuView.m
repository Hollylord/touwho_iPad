//
//  JiGouMenuView.m
//  touwho_iPad
//
//  Created by apple on 15/9/15.
//  Copyright © 2015年 touhu.com. All rights reserved.
//
#define MarginSide 30
#define MarginTop 30
#define Width 400
#define Height 150

#import "JiGouMenuView.h"

#import "JiGouUnit.h"
#import "ModelForJiGouUnit.h"

@interface JiGouMenuView ()

@end

@implementation JiGouMenuView
{
    UIScrollView *scrollView;
    
}

- (void)setModels:(NSMutableArray *)models{
    if (_models != models) {
        _models = models;
    }
    
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    //创建view
    for (int i = 0 ; i < models.count; i ++) {
        JiGouUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"JiGouUnit" owner:self options:nil]firstObject];
        unit.model = self.models[i];
        [scrollView addSubview:unit];
    }
    
    //布局
    for (int i = 0 ; i < scrollView.subviews.count; i ++) {
        UIView *view = scrollView.subviews[i];
        int column = i % 2;//列数
        int line = (int) i / 2;//行数
        
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant: column * (MarginSide + Width)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:MarginTop + line *(MarginTop + Height)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        
        [view.superview addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    //设置scrollview的滚动范围
    if (scrollView.subviews.count == 0) {
        return ;
    }
    
    UIView *view = scrollView.subviews.lastObject;
    NSLayoutConstraint *trailing2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    NSLayoutConstraint *bottom2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[trailing2,bottom2]];
    
    [scrollView setNeedsUpdateConstraints];
    
}

//如果使用纯代码写，则init方法里面可以设置self子视图与子视图之间的层次关系
- (instancetype)init{
    self = [super init];
    if (self) {

        UIScrollView *scroll = [[UIScrollView alloc] init];
        scrollView = scroll;
        [self addSubview:scrollView];
        //scrollview中内含有滚动条，也会占到它的subview中
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delaysContentTouches = NO;
    }
    return self;
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


}





@end
