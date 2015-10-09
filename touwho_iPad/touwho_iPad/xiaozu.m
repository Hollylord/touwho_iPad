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


@implementation xiaozu
{
    //存放热门小组view
    NSMutableArray *hotGroup;
    //存放我加入的小组view
    NSMutableArray *iInvolved;
    //存放热门小组model
    NSMutableArray *hotModelArr;
    //存放加入的小组model
    NSMutableArray *iInvoModelArr;
}

//只会初始化自己 不能在这里面添加子视图的子视图，设置层级关系无效。只能设置self 与子视图的层级关系
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        hotGroup = [NSMutableArray array];
        iInvolved = [NSMutableArray array];
        hotModelArr = [NSMutableArray array];
        iInvoModelArr = [NSMutableArray array];
        
        NSArray *groupNamesArr1 = @[@"经济学人",@"投壶咨询组",@"驴友"];
        //添加数据到hotModelArr
        for (int i = 0; i < 3; i ++) {
            ModelForGroup *model = [[ModelForGroup alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"touxiang%d",i + 1];
            model.icon = [UIImage imageNamed:imageName];
            model.name = groupNamesArr1[i];
            [hotModelArr addObject:model];
        }
        
        NSArray *groupNamesArr2 = @[@"上班这件事",@"闲置二手",@"居家装饰",@"深圳歌友会"];
        //添加数据到hotModelArr
        for (int i = 4; i < 8; i ++) {
            ModelForGroup *model = [[ModelForGroup alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"touxiang%d",i];
            model.icon = [UIImage imageNamed:imageName];
            model.name = groupNamesArr2[i-4];
            [iInvoModelArr addObject:model];
        }
        
    }
    return self;
}

//相当于viewDidLoad
- (void)awakeFromNib{
    //添加热门小组
    for (int i = 0; i < 3; i ++) {
        xiaozuUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"xiaozuUnit" owner:self options:nil]firstObject];
        unit.model = hotModelArr[i];
        [self.scrollView addSubview:unit];
        [hotGroup addObject:unit];
    }
    //添加我加入的小组
    for (int i = 0; i < 4; i ++) {
        xiaozuUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"xiaozuUnit" owner:self options:nil]firstObject];
        unit.model = iInvoModelArr[i];
        [self.scrollView addSubview:unit];
        [iInvolved addObject:unit];
    }
}

- (void)updateConstraints{
    [super updateConstraints];
    
    //布局热门推荐
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
    
    //布局我加入的小组
    NSUInteger totalNumber2 = iInvolved.count;
    for (int i = 0; i < totalNumber2; i ++) {
        //列数
        int column = i%3;
        //行数
        int lines = (int) i/3;
        
        UIView *view = iInvolved[i];
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
            NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:hotGroup.lastObject attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
            [self.scrollView addConstraint:top];
        }
    }
    //布局scrollview的竖直滚动范围
    NSLayoutConstraint *verticalScale = [NSLayoutConstraint constraintWithItem:[iInvolved lastObject] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    [self.scrollView addConstraint:verticalScale];

}


@end
