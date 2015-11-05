//
//  xiaozu.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.


#import "xiaozu.h"
#import "SpecificGroupViewController.h"
#import "ModelForGroup.h"
#import "xiaozuUnit.h"

#define Width 240
#define Height 90
#define MarginTop 20
#define MarginSide 30

@interface xiaozu ()
///存放热门的小组view
@property (strong,nonatomic)  NSMutableArray *hotGroup;
///存放我加入的小组view
@property (strong,nonatomic)  NSMutableArray *iInvolved;
@end

@implementation xiaozu

- (NSMutableArray *)hotGroup{
    if (!_hotGroup) {
        _hotGroup = [NSMutableArray array];
    }
    return _hotGroup;
}
- (NSMutableArray *)iInvolved{
    if (!_iInvolved) {
        _iInvolved = [NSMutableArray array];
    }
    return _iInvolved;
}

- (void)setHotModels:(NSMutableArray *)hotModels{
    if (_hotModels != hotModels) {
        _hotModels = hotModels;
    }
    
    self.hotGroup = nil;
    
    //添加热门小组
    for (int i = 0; i < hotModels.count; i ++) {
        xiaozuUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"xiaozuUnit" owner:self options:nil]firstObject];
        unit.model = hotModels[i];
        [self.scrollView addSubview:unit];
        [self.hotGroup addObject:unit];
    }
    //布局
    [self layoutHotGroups];
    if (self.hotGroup.count == 0) {
        return ;
    }
    //布局scrollview的竖直滚动范围
    NSLayoutConstraint *verticalScale = [NSLayoutConstraint constraintWithItem:[self.hotGroup lastObject] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    verticalScale.priority = 500;
    [self.scrollView addConstraint:verticalScale];
    
    //更新布局
    [self.scrollView setNeedsUpdateConstraints];
}

- (void)setMyModels:(NSMutableArray *)myModels{
    if (_myModels != myModels) {
        _myModels = myModels;
    }
    
    if (myModels.count == 0) {
        return;
    }
    //布局label2
    for (NSLayoutConstraint *constraint in self.scrollView.constraints) {
        if ([constraint.identifier isEqualToString:@"label2TopConstraint"]) {
            [self.scrollView removeConstraint:constraint];
            NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.hotGroup.lastObject attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
            [self.scrollView addConstraint:top];
        }
    }
    self.label2.hidden = NO;
    self.splitLine2.hidden = NO;
    
    self.iInvolved = nil;
    
    //添加我加入的小组
    for (int i = 0; i < myModels.count; i ++) {
        xiaozuUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"xiaozuUnit" owner:self options:nil]firstObject];
        unit.model = myModels[i];
        [self.scrollView addSubview:unit];
        [self.iInvolved addObject:unit];
    }
    [self layoutMyGroup];
    if (self.iInvolved.count == 0) {
        return ;
    }
    //布局scrollview的竖直滚动范围
    NSLayoutConstraint *verticalScale = [NSLayoutConstraint constraintWithItem:[self.iInvolved lastObject] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    verticalScale.priority = 1000;
    [self.scrollView addConstraint:verticalScale];
    
    //更新布局
    [self.scrollView setNeedsUpdateConstraints];
    
}


//相当于viewDidLoad
- (void)awakeFromNib{

    self.label2.hidden = YES;
    self.splitLine2.hidden = YES;
    

}
- (void)layoutHotGroups{
    //布局热门推荐
    NSUInteger totalNumber = self.hotGroup.count;
    for (int i = 0; i < totalNumber; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;

        UIView *view = self.hotGroup[i];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.splitLine1 attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column * (Width+MarginSide)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.splitLine1 attribute:NSLayoutAttributeBottom multiplier:1 constant:MarginTop + lines * (Height + MarginTop)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        [view.superview addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void)layoutMyGroup{
    //布局我加入的小组
    NSUInteger totalNumber2 = self.iInvolved.count;
    for (int i = 0; i < totalNumber2; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;

        UIView *view = self.iInvolved[i];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.splitLine2 attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column * (Width+MarginSide)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.splitLine2 attribute:NSLayoutAttributeBottom multiplier:1 constant:MarginTop + lines * (Height + MarginTop)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        [view.superview addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}




@end
