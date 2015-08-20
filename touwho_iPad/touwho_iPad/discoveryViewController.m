//
//  discoveryViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "discoveryViewController.h"
#import "shipinMenuView.h"

@interface discoveryViewController ()

@property (strong,nonatomic) shipinMenuView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *line;

- (IBAction)buttonClick:(UIButton *)sender;


@end

@implementation discoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turn2shipinController) name:@"playNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)turn2shipinController{
    
}

//视频页面的懒加载
- (UIView *)contentView{
    if (!_contentView)
    {
        shipinMenuView *view = [[shipinMenuView alloc] init];
        _contentView = view;
    }
    return _contentView;
}

#pragma mark - 按钮点击
- (IBAction)buttonClick:(UIButton *)sender {
    //点击视频路演按钮
    if (sender.tag == 1) {
        [self.view addSubview:self.contentView];
        self.contentView.backgroundColor = [UIColor redColor];
        [self layoutForContentView:self.contentView];
        
        
    }
    //点击机构专题
    else if (sender.tag == 2)
    {
        [self.contentView removeFromSuperview];
    }
}

#pragma mark 布局视频页面
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
    [UIView animateWithDuration:2.0 animations:^{
        [self.view removeConstraint:leading];
        [self.view addConstraint:leading2];
        [self.view layoutIfNeeded];
        
    }];
    
    
}
@end
