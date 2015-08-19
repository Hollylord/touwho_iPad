//
//  leftViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "leftViewController.h"


@interface leftViewController () <UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *program;
@property (weak, nonatomic) IBOutlet UIButton *news;
@property (weak, nonatomic) IBOutlet UIButton *discovery;
@property (weak, nonatomic) IBOutlet UIButton *me;

- (IBAction)menuClick:(UIButton *)sender;




@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.program.selected = YES;
    self.news.selected = NO;
    self.discovery.selected = NO;
    self.me.selected = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 按钮点击
- (IBAction)menuClick:(UIButton *)sender {
    if (sender.tag == 0 ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"programNotification" object:nil];
        self.program.selected = YES;
        self.news.selected = NO;
        self.discovery.selected = NO;
        self.me.selected = NO;
        
    }
    else if (sender.tag == 1 )
    {
        self.program.selected = NO;
        self.news.selected = YES;
        self.discovery.selected = NO;
        self.me.selected = NO;
        
    }
    else if (sender.tag == 2 )
    {
        self.program.selected = NO;
        self.news.selected = NO;
        self.discovery.selected = YES;
        self.me.selected = NO;
    }
    else {
        //发送被点击的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotification" object:nil];
        self.program.selected = NO;
        self.news.selected = NO;
        self.discovery.selected = NO;
        self.me.selected = YES;
    }
    
}
@end
