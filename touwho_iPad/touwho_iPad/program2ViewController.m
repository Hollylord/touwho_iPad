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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    programView *view = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil]firstObject];
    view.backgroundColor = [UIColor redColor];
    [self.program addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    /** 给programview添加约束**/
    programView *view = self.program.subviews[0];
    [self layoutForProgram:view];
}
- (void)layoutForProgram:(programView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}
@end
