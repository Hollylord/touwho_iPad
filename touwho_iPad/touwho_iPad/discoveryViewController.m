//
//  discoveryViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "discoveryViewController.h"

@interface discoveryViewController ()
@property (weak,nonatomic) UIView *contentView;
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
#pragma mark - 按钮点击

- (IBAction)buttonClick:(UIButton *)sender {
    //点击视频路演按钮
    if (sender.tag == 1) {
        UIView *view = [[UIView alloc] init];
        self.contentView = view;
        [self.view addSubview:view];
        self.contentView.backgroundColor = [UIColor redColor];
        [self layoutForContentView:self.contentView];
        

    }
}
- (void)layoutForContentView:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *leading2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraints:@[leading,top,width,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view layoutIfNeeded];
    
    NSLog(@"%@",NSStringFromCGRect(view.frame));
    
    
    [UIView animateWithDuration:2.0 animations:^{
        [self.view removeConstraint:leading];
        [self.view addConstraint:leading2];
        [self.view layoutIfNeeded];
        
        NSLog(@"%@",NSStringFromCGRect(view.frame));
    }];
    
    
}
@end
