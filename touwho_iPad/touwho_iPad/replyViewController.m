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
    [TalkingData trackPageBegin:@"回复页"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"回复页"];
}
#pragma mark - 按钮点击
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//发布回复
- (IBAction)publish:(UIBarButtonItem *)sender {
    NSDictionary *para = @{@"method":@"addOneTalk",@"talk_id":self.topic_id,@"content":self.contentView.text,@"user_id":USER_ID};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"发送成功";
        [hud hide:YES afterDelay:0.5];
        hud.completionBlock = ^(){
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:NULL];
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

@end
