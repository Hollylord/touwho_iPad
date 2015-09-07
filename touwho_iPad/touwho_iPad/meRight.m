//
//  meRight.m
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "meRight.h"
#import "message.h"

@implementation meRight
#pragma mark - meleft代理
//发布项目
- (void)presentPublish{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"publish" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
    
}
//已投资的项目
- (void)presentPrograms{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UITableView *programs = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    programs.delegate = self;
    programs.dataSource = self;
    [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self addSubview:programs];
    [self layoutForSubview:programs];

}
//申请为领头
- (void)presentApply{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"apply" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
}
//申请为投资人
- (void)presentSponsor{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"apply" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
}

- (void)presentProfile{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"profile" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
}

- (void)presentMessage{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    message *view = [[[NSBundle mainBundle] loadNibNamed:@"message" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
    NSLog(@"%@",NSStringFromCGRect(view.frame));
}
- (void)layoutForSubview:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.superview layoutIfNeeded];

}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
