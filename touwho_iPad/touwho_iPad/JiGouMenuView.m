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
#import "JiGouDetailViewController.h"
#import "JiGouUnit.h"
#import "ModelForJiGouUnit.h"



@implementation JiGouMenuView
{
    UIScrollView *scrollView;
    //用来装model的数组
    NSMutableArray *arrayFormodel;
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
        
        arrayFormodel = [NSMutableArray array];
        NSArray *jigouName = @[@"顺丰速运",@"京道基金",@"君盛投资",@"高特佳",@"大正元",@"东方赛富",@"TCL",@"同威创投"];
        for (int i = 0; i < 8; i ++) {
            ModelForJiGouUnit *model = [[ModelForJiGouUnit alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"jigou%d",i];
            model.image = [UIImage imageNamed:imageName];
            model.title1 = jigouName[i];
            model.time = @"2015-9-30";
            model.title2 = @"投壶网合作伙伴";
            
            [arrayFormodel addObject:model];
        }
        
        for (int i = 0 ; i < 8; i ++) {
            JiGouUnit *unit = [[[NSBundle mainBundle] loadNibNamed:@"JiGouUnit" owner:self options:nil]firstObject];
            unit.model = arrayFormodel[i];
            [scrollView addSubview:unit];
        }
        
        
        
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

    //给JiGouUnit添加约束
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
    UIView *view = scrollView.subviews.lastObject;
    NSLayoutConstraint *trailing2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    NSLayoutConstraint *bottom2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[trailing2,bottom2]];


}





- (IBAction)turn2JiGouVC:(UITapGestureRecognizer *)sender {
    UIViewController *VC = [self viewController];
    JiGouDetailViewController *jiGouVC = [[JiGouDetailViewController alloc] initWithNibName:@"JiGouDetailViewController" bundle:nil];
    [VC.navigationController pushViewController:jiGouVC animated:YES];
}

- (IBAction)follow:(UIButton *)sender {
    NSLog(@"关注");
}

//获得当前view的控制器
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
