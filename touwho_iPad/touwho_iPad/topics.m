//
//  topics.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "topics.h"

#define Width 240
#define Height 180
#define MarginTop 20
#define MarginSide 30


@implementation topics
{
    NSMutableArray *hotTopics;//热门推荐话题
    NSMutableArray *involedTopics;//我参加的话题
}

//只会初始化自己 不能在这里面添加子视图的子视图，设置层级关系无效。只能设置self 与子视图的层级关系
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        hotTopics = [NSMutableArray array];
        involedTopics = [NSMutableArray array];
        
    }
    return self;
}

//相当于viewDidLoad
- (void)awakeFromNib{
    //添加热门话题
    for (int i = 0; i < 5; i ++) {
        UIView *unit = [[[NSBundle mainBundle] loadNibNamed:@"TopicUnit" owner:self options:nil]firstObject];
        [self.scrollView addSubview:unit];
        [hotTopics addObject:unit];
    }
    //添加我加入的小组
    for (int i = 0; i < 6; i ++) {
        UIView *unit = [[[NSBundle mainBundle] loadNibNamed:@"TopicUnit" owner:self options:nil]firstObject];
        [self.scrollView addSubview:unit];
        [involedTopics addObject:unit];
    }
}

- (void)updateConstraints{
    [super updateConstraints];
    
    //布局热门推荐
    NSUInteger totalNumber = hotTopics.count;
    for (int i = 0; i < totalNumber; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;
        
        UIView *view = hotTopics[i];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.splitLine1 attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column * (Width+MarginSide)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.splitLine1 attribute:NSLayoutAttributeBottom multiplier:1 constant:MarginTop + lines * (Height + MarginTop)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        [view.superview addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    //布局我加入的小组
    NSUInteger totalNumber2 = involedTopics.count;
    for (int i = 0; i < totalNumber2; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;
        
        UIView *view = involedTopics[i];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.splitLine2 attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column * (Width+MarginSide)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.splitLine2 attribute:NSLayoutAttributeBottom multiplier:1 constant:MarginTop + lines * (Height + MarginTop)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        [view.superview addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    //布局label2
    for (NSLayoutConstraint *constraint in self.scrollView.constraints) {
        if ([constraint.identifier isEqualToString:@"label2TopConstraint"]) {
            [self.scrollView removeConstraint:constraint];
            NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:hotTopics.lastObject attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
            [self.scrollView addConstraint:top];
        }
    }
    //布局scrollview的竖直滚动范围
    NSLayoutConstraint *verticalScale = [NSLayoutConstraint constraintWithItem:[involedTopics lastObject] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    [self.scrollView addConstraint:verticalScale];
    
}



@end
