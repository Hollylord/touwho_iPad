//
//  program2ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/2.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "program2ViewController.h"
#import "programView.h"
@interface program2ViewController ()
/**
 *  左上角的项目view
 */
@property (weak, nonatomic) IBOutlet UIView *program;


@end

@implementation program2ViewController
{
    programView *viewForprogram;//左上角的项目视图
    UIButton *btn;//关注按钮
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加programView视图
    programView *view = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil]firstObject];
    view.backgroundColor = [UIColor redColor];
    [self.program addSubview:view];
    viewForprogram = view;
    
    //添加关注按钮
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [view addSubview:followBtn];
    followBtn.backgroundColor = [UIColor greenColor];
    [followBtn setTitle:@"关注" forState:UIControlStateNormal];
    btn = followBtn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

/**
 *  控制器的子视图更新约束(添加一些新视图的约束)
 */
- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    
    [self layoutForFollowBtn:btn];
    
    [self layoutForProgram:viewForprogram];
    
}
- (void)layoutForProgram:(programView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.program addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)layoutForFollowBtn:(UIView *)view {
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-20];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    
    [view.superview addConstraints:@[trailing,top]];
    view.translatesAutoresizingMaskIntoConstraints = NO;


}
@end
