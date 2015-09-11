//
//  xiaozu.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.


#import "xiaozu.h"

#define Width 240
#define Height 180
#define MarginTop 20
#define MarginSide 30


@implementation xiaozu
{
    NSMutableArray *hotGroup;
}

//只会初始化自己 不能在这里面添加子视图，设置层级关系无效
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        hotGroup = [NSMutableArray array];

    }
    return self;
}

//相当于viewDidLoad
- (void)awakeFromNib{
    for (int i = 0; i < 5; i ++) {
        UIView *unit = [[[NSBundle mainBundle] loadNibNamed:@"xiaozuUnit" owner:nil options:nil]firstObject];
        [self.scrollView addSubview:unit];
        [hotGroup addObject:unit];
    }
}

- (void)updateConstraints{
    [super updateConstraints];
    
    NSUInteger totalNumber = hotGroup.count;
    
    for (int i = 0; i < totalNumber; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;
        
        UIView *view = hotGroup[i];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.splitLine1 attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column * (Width+MarginSide)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.splitLine1 attribute:NSLayoutAttributeBottom multiplier:1 constant:MarginTop + lines * (Height + MarginTop)];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        [view.superview addConstraints:@[leading,top]];
        [view addConstraints:@[width,height]];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    
    for (NSLayoutConstraint *constraint in self.scrollView.constraints) {
        if ([constraint.identifier isEqualToString:@"label2TopConstraint"]) {
            [self.scrollView removeConstraint:constraint];
            NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:hotGroup.lastObject attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
            [self.scrollView addConstraint:top];
        }
    }

}


@end
