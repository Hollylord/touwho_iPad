//
//  discoveryViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "discoveryViewController.h"
#import "shipinMenuView.h"
#import "disscussionMenu.h"

#define Width 230
#define Height 200
#define MarginSide 30
#define MarginTop 30
#define Number 3 //每行的话题数

@interface discoveryViewController ()

@property (strong,nonatomic) UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *line;

@property (weak, nonatomic) IBOutlet UIButton *footage;
@property (weak, nonatomic) IBOutlet UIButton *discussion;
@property (weak, nonatomic) IBOutlet UIButton *institutions;
@property (weak, nonatomic) IBOutlet UIButton *reviews;

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
    [self performSegueWithIdentifier:@"discovery2shipinViewController" sender:nil];
}

//视频页面的懒加载
- (UIView *)contentView{
    if (!_contentView)
    {
        if (self.footage.selected) {
            shipinMenuView *view = [[shipinMenuView alloc] init];
            _contentView = view;
        }
        else if (self.discussion.selected){
            disscussionMenu *view = [[[NSBundle mainBundle]loadNibNamed:@"disscussionMenu" owner:nil options:nil] firstObject];
            _contentView = view;
        }
        
    }
    return _contentView;
}

#pragma mark - 按钮点击
- (IBAction)buttonClick:(UIButton *)sender {
    //点击视频路演按钮
    if (sender.tag == 1 && sender.selected == NO) {
        sender.selected = YES;
        self.institutions.selected = NO;
        self.discussion.selected = NO;
        self.reviews.selected = NO;
        [self.contentView removeFromSuperview];
        self.contentView = nil;
        [self.view addSubview:self.contentView];
        self.contentView.backgroundColor = [UIColor redColor];
        [self layoutForContentView:self.contentView];
        
        
    }
    //点击行业讨论
    else if (sender.tag == 2 && sender.selected == NO)
    {
        sender.selected = YES;
        self.footage.selected = NO;
        self.institutions.selected = NO;
        self.reviews.selected = NO;
        
        //添加discussionMenu
        [self.contentView removeFromSuperview];
        self.contentView = nil;
        disscussionMenu *menu = (disscussionMenu *)self.contentView;
        [self.view addSubview:self.contentView];
        [self layoutForContentView:self.contentView];
        [self layoutForDiscussionMenu:menu];
        
        
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
    [UIView animateWithDuration:1.0 animations:^{
        [self.view removeConstraint:leading];
        [self.view addConstraint:leading2];
        [self.view layoutIfNeeded];
        
    }];
    
    
}

#pragma mark 布局行业讨论
- (void)layoutForDiscussionMenu:(disscussionMenu *)menu{
    for (int i = 0; i < 5; i ++) {
        UIView *topic = [[[NSBundle mainBundle] loadNibNamed:@"topics" owner:nil options:nil]firstObject];
        [menu.scrollView addSubview:topic];
        //列数
        int column = i%Number;
                //行数
        int line = (int)i/Number;
        
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:topic attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:menu.line attribute:NSLayoutAttributeLeading multiplier:1 constant:column * (Width + MarginSide)];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:topic attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:menu.line attribute:NSLayoutAttributeBottom multiplier:1 constant:line * (Height +MarginTop) + MarginTop];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:topic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:topic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
        
        topic.translatesAutoresizingMaskIntoConstraints = NO;
        [menu.scrollView addConstraints:@[leading,top]];
        [topic addConstraints:@[width,height]];
//        view.translatesAutoresizingMaskIntoConstraints = NO;
        

    }
}
@end
