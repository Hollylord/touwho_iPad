//
//  discoveryViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "discoveryViewController.h"
#import "shipinMenuView.h"
#import "circle.h"
#import "activityList.h"


#define Width 230
#define Height 170
#define MarginSide 30
#define MarginTop 30
#define Number 3 //每行的话题数

@interface discoveryViewController ()

@property (strong,nonatomic) UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *line;

@property (weak, nonatomic) IBOutlet UIButton *footage;//路演
@property (weak, nonatomic) IBOutlet UIButton *discussion;//圈子
@property (weak, nonatomic) IBOutlet UIButton *activity;//活动




- (IBAction)buttonClick:(UIButton *)sender;


@end

@implementation discoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self buttonClick:self.discussion];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [TalkingData trackPageBegin:@"社群页面"];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"社群页面"];
}
#pragma mark - 内容页面懒加载
- (UIView *)contentView{
    if (!_contentView)
    {
        if (self.footage.selected) {
            shipinMenuView *view = [[shipinMenuView alloc] init];
            _contentView = view;
        }
        else if (self.discussion.selected){
            circle *view = [[[NSBundle mainBundle] loadNibNamed:@"circle" owner:nil options:nil]firstObject];
            _contentView = view;
        }
        else if (self.activity.selected){
            activityList *view = [[activityList alloc] init];
            _contentView = view;
        }
        
    }
    return _contentView;
}

#pragma mark - 顶部按钮点击

- (IBAction)buttonClick:(UIButton *)sender {
    //视频
    if (sender.tag == 1 && sender.selected == NO) {
        [TalkingData trackEvent:@"查看视频列表"];
        
        sender.selected = YES;
        self.discussion.selected = NO;
        self.activity.selected = NO;
        
        [self.contentView removeFromSuperview];
        self.contentView = nil;
        [self.view addSubview:self.contentView];
        
        [self layoutForContentView:self.contentView];
        
        
    }
    //社群
    else if (sender.tag == 2 && sender.selected == NO)
    {
        [TalkingData trackEvent:@"查看社群列表"];
        
        sender.selected = YES;
        self.footage.selected = NO;
        self.activity.selected = NO;
        
        //添加圈子
        [self.contentView removeFromSuperview];
        self.contentView = nil;
        [self.view addSubview:self.contentView];
        [self layoutForContentView:self.contentView];
    }
    //活动
    else if (sender.tag == 3 && sender.selected == NO)
    {
        [TalkingData trackEvent:@"查看活动列表"];
        
        sender.selected = YES;
        self.footage.selected = NO;
        self.discussion.selected = NO;
        
        //添加活动列表
        [self.contentView removeFromSuperview];
        self.contentView = nil;
        [self.view addSubview:self.contentView];
        [self layoutForContentView:self.contentView];
    }
}

#pragma mark 布局contentView页面
- (void)layoutForContentView:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *leading2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraints:@[leading,top,width,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view layoutIfNeeded];
    
    //动画
    [UIView animateWithDuration:1.0 animations:^{
        [self.view removeConstraint:leading];
        [self.view addConstraint:leading2];
        [self.view layoutIfNeeded];
        
    }];
    
    
}


@end
