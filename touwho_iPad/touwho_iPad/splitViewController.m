//
//  splitViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "splitViewController.h"

@interface splitViewController ()

//个人信息页面的返回按钮
- (IBAction)meBack:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *meLeftView;
@property (strong,nonatomic) UIView *meRightView;
@end

@implementation splitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.minimumPrimaryColumnWidth = 100;
    self.maximumPrimaryColumnWidth = 100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:nil object:nil];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"programNotification"]) {
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"shouye"] sender:nil];
    }
    else if ([notification.name isEqualToString:@"discoveryNotification"]){
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"discoveryNavigation"] sender:nil];
    }
}

//展开me的视图
- (void)extentMeView{
    //添加左边view
    UIView *me = [[[NSBundle mainBundle] loadNibNamed:@"meLeft" owner:self options:nil]firstObject];
    [self.view addSubview:me];
    [self layoutForMe:me];
    
    //添加右边view
    UIView *meRight = [[UIView alloc] init];
    meRight.backgroundColor = [UIColor blueColor];
    [self.view addSubview:meRight];
    self.meRightView = meRight;
    [self layoutForMeRight:meRight];
    
}

- (void)layoutForMe:(UIView *)view{
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self.view addConstraints:@[trailing,top,bottom]];
    [view addConstraint:width];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:1 animations:^{
        [self.view removeConstraint:trailing];
        [self.view addConstraint:leading];
        [self.view layoutIfNeeded];
        
    }];
}
- (void)layoutForMeRight:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.view.frame.size.width - 300];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [self.view addConstraints:@[leading,top,bottom]];
    [view addConstraint:width];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:1 animations:^{
        [self.view removeConstraint:leading];
        [self.view addConstraint:trailing];
        [self.view layoutIfNeeded];
        
    }];
}

#pragma mark - 返回按钮
- (IBAction)meBack:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        self.meLeftView.transform = CGAffineTransformMakeTranslation(-300, 0);
        self.meRightView.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width - 300, 0);
    } completion:^(BOOL finished) {
        [self.meLeftView removeFromSuperview];
        [self.meRightView removeFromSuperview];
    }];
    
}
@end
