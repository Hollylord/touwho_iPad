//
//  topics.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "topics.h"
#import "TopicUnit.h"

#define Width 240
#define Height 90
#define MarginTop 20
#define MarginSide 30

@interface topics ()
///存放热门话题view
@property (strong,nonatomic) NSMutableArray *hotTopics;
///存放参与的话题view
@property (strong,nonatomic) NSMutableArray *involedTopics;
@end

@implementation topics

-(NSMutableArray *)hotTopics{
    if (!_hotTopics) {
        _hotTopics = [NSMutableArray array];
    }
    return _hotTopics;
}
- (NSMutableArray *)involedTopics{
    if (!_involedTopics) {
        _involedTopics = [NSMutableArray array];
    }
    return _involedTopics;
}

//相当于viewDidLoad
- (void)awakeFromNib{
    
    self.label2.hidden = YES;
    self.splitLine2.hidden = YES;
    
    
}
- (void)setHotModels:(NSMutableArray *)hotModels{
    if (_hotModels != hotModels) {
        _hotModels = hotModels;
    }
    
    self.hotTopics = nil;
    
    //添加热门话题
    for (int i = 0; i < self.hotModels.count; i ++) {
        TopicUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"TopicUnit" owner:nil options:nil]firstObject];
        unit.model = self.hotModels[i];
        [self.scrollView addSubview:unit];
        [self.hotTopics addObject:unit];
    }
    
    //布局
    [self layoutHotGroups];
    
    if (self.hotTopics.count == 0) {
        return ;
    }
    
    //布局scrollview的竖直滚动范围
    NSLayoutConstraint *verticalScale = [NSLayoutConstraint constraintWithItem:[self.hotTopics lastObject] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
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
            NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.hotTopics.lastObject attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
            [self.scrollView addConstraint:top];
        }
    }
    
    self.label2.hidden = NO;
    self.splitLine2.hidden = NO;
    
    self.involedTopics = nil;
    
    //添加我加入的小组
    for (int i = 0; i < self.myModels.count; i ++) {
        TopicUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"TopicUnit" owner:nil options:nil]firstObject];
        unit.model = self.myModels[i];
        [self.scrollView addSubview:unit];
        [self.involedTopics addObject:unit];
    }
    [self layoutMyGroup];
    
    if (self.involedTopics.count == 0) {
        return ;
    }
    //布局scrollview的竖直滚动范围
    NSLayoutConstraint *verticalScale = [NSLayoutConstraint constraintWithItem:[self.involedTopics lastObject] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    verticalScale.priority = 1000;
    [self.scrollView addConstraint:verticalScale];
    
    //更新布局
    [self.scrollView setNeedsUpdateConstraints];
    
}

- (void)layoutHotGroups{
    //布局热门推荐
    NSUInteger totalNumber = self.hotTopics.count;
    for (int i = 0; i < totalNumber; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;
        
        UIView *view = self.hotTopics[i];
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
    NSUInteger totalNumber2 = self.involedTopics.count;
    for (int i = 0; i < totalNumber2; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;
        
        UIView *view = self.involedTopics[i];
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
