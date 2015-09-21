//
//  meRight.m
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "meRight.h"
#import "message.h"
#import "profileViewController.h"
#import "profile.h"
#import "ProgramsTableViewCell.h"
#import "ProgramsModel.h"


@implementation meRight
{
    UITableView *institutionTableView;
    UITableView *investedProgramsTableView;
    UITableView *publishedProgramsTableView;
    UITableView *followedProgramsTableView;
    ProgramsModel *model;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        model = [[ProgramsModel alloc] init];
        model.image = [UIImage imageNamed:@"logo"];
    }
    return self;
}


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
//编辑个人信息页面的设置
- (void)presentProfile{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    profile *view = [[[NSBundle mainBundle] loadNibNamed:@"profile" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
    
    //设置拍到照片后的回调方法：显示图片
    profileViewController *VC = (profileViewController *)[self viewController];
    VC.presentBusinessCard = ^(UIImage * image){
        [view.businessCard setImage:image];
        
    };
    
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
//发起的项目
- (void)presentPublished{
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
//关注的项目
- (void)presentFollowedProgram{
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
//关注的机构
- (void)presentFollowedInstitution{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UITableView *institution = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];

    institution.delegate = self;
    institution.dataSource = self;
    [institution registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self addSubview:institution];
    [self layoutForSubview:institution];
    
}

//消息
- (void)presentMessage{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    message *view = [[[NSBundle mainBundle] loadNibNamed:@"message" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
    
}


- (void)layoutForSubview:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:20];
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
    ProgramsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
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
