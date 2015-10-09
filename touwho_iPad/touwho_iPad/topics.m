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


@implementation topics
{
    //存放热门话题view
    NSMutableArray *hotTopics;
    //存放参与的话题view
    NSMutableArray *involedTopics;
    
    //存放热门话题model
    NSMutableArray *hotModelArr;
    //存放参与的话题model
    NSMutableArray *iInvoModelArr;
}

//只会初始化自己 不能在这里面添加子视图的子视图，设置层级关系无效。只能设置self 与子视图的层级关系
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        hotTopics = [NSMutableArray array];
        involedTopics = [NSMutableArray array];
        hotModelArr = [NSMutableArray array];
        iInvoModelArr = [NSMutableArray array];
        
        NSArray *topicNamesArr1 = @[@"沪指大涨3%",@"青蒿素发展史",@"港囧"];
        NSArray *groupNamesArr1 = @[@"经济学人",@"投壶咨询组",@"驴友"];
        //添加数据到热门小组
        for (int i = 0; i < 3; i ++) {
            ModelForTopic *model = [[ModelForTopic alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"touxiang%d",i + 1];
            model.publisher.icon = [UIImage imageNamed:imageName];
            model.title = topicNamesArr1[i];
            model.group.name = groupNamesArr1[i];
            model.time = @"2015-10-9";
            [hotModelArr addObject:model];
        }
        
        NSArray *groupNamesArr2 = @[@"上班这件事",@"闲置二手",@"居家装饰",@"深圳歌友会"];
        NSArray *topicNamesArr2 = @[@"上班这件事",@"闲置二手",@"居家装饰",@"深圳歌友会"];
        //添加数据到参与的小组
        for (int i = 4; i < 8; i ++) {
            ModelForTopic *model = [[ModelForTopic alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"touxiang%d",i];
            model.publisher.icon = [UIImage imageNamed:imageName];
            model.title = topicNamesArr2[i-4];
            model.group.name = groupNamesArr2[i-4];
            model.time = @"2015-10-9";
            [iInvoModelArr addObject:model];
        }
    }
    return self;
}

//相当于viewDidLoad
- (void)awakeFromNib{
    //添加热门话题
    for (int i = 0; i < hotModelArr.count; i ++) {
        TopicUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"TopicUnit" owner:nil options:nil]firstObject];
        unit.model = hotModelArr[i];
        [self.scrollView addSubview:unit];
        [hotTopics addObject:unit];
    }
    //添加我加入的小组
    for (int i = 0; i < iInvoModelArr.count; i ++) {
        TopicUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"TopicUnit" owner:nil options:nil]firstObject];
        unit.model = iInvoModelArr[i];
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
