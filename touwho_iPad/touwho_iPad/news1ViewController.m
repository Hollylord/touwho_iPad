//
//  news1ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "news1ViewController.h"
#import "newsMenu.h"
#define MarginSide 50
#define MarginTop 30
#define Width 400
#define Height 200

@interface news1ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation news1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    for (int i = 0; i < 5; i ++) {
        newsMenu *view = [[[NSBundle mainBundle]loadNibNamed:@"newsMenu" owner:nil options:nil]firstObject];
        
        view.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:view];
        [self layoutForNewsMenu:view index:i];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutForNewsMenu:(newsMenu *)view index:(int)i{
    //行数
    int line = (int)i/2;
    //列数
    int column = i%2;
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column*(MarginSide + Width)];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0 + line*(MarginTop + Height)];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
    [self.scrollView addConstraints:@[leading,top]];
    [view addConstraints:@[width,height]];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView layoutIfNeeded];
    //设置滚动范围
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(view.frame) + 20);
}

@end
