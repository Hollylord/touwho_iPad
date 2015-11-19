//
//  AboutViewController.m
//  touwho_iPad
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [dic objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = version;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [TalkingData trackPageBegin:@"关于页"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"关于页"];
}
- (IBAction)returnBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
