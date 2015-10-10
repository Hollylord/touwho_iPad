//
//  news1ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "news1ViewController.h"
#import "newsMenu.h"
#import "news2ViewController.h"
#import "ModelForNews.h"

#define MarginSide 50
#define MarginTop 30
#define Width 400
#define Height 150

@interface news1ViewController () <newsMenuDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation news1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建数据
    ModelForNews *model = [[ModelForNews alloc] init];
    model.iconImage = [UIImage imageNamed:@"yuwang"];
    model.title = @"习近平向金正恩致贺电";
    model.time = @"2015-10-10";
    model.abstract = @"习近平在贺电中说，在朝鲜劳动党成立70周年之际，我代表中国共产党中央委员会，并以我个人的名义，向你并通过你，向朝鲜劳动党中央、全体党员以及全体朝鲜人民致以热烈的祝贺。";
    
    for (int i = 0; i < 5; i ++) {
        newsMenu *view = [[[NSBundle mainBundle]loadNibNamed:@"newsMenu" owner:nil options:nil]firstObject];
        view.delegate = self;
        view.model = model;
        [self.scrollView addSubview:view];
        [self layoutForNewsMenu:view index:i];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

#pragma mark - newsMenu代理
//跳转新闻详细页面
- (void)turn2newsDetail{
    
    news2ViewController *viewcontroller = [[news2ViewController alloc]initWithNibName:@"news2ViewController" bundle:nil];
    [self.navigationController pushViewController:viewcontroller animated:YES];

}
@end
