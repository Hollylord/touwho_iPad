//
//  replyViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "replyViewController.h"

@interface replyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentView;
/**
 *  取消按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)cancel:(UIBarButtonItem *)sender;

@end

@implementation replyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.contentView becomeFirstResponder];
}
#pragma mark - 按钮点击
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
