//
//  LingTouViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "LingTouViewController.h"

@interface LingTouViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *topTitle;
///输入框
@property (weak, nonatomic) IBOutlet UITextField *inputView;

///投资金额
@property (strong,nonatomic) NSString *amountInvestment;




@end

@implementation LingTouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置顶部title
    if (self.isLingtou) {
        self.topTitle.title = @"领头金额";
    }
    else{
        self.topTitle.title = @"跟头金额";
    }
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [TalkingData trackPageBegin:@"投资金额选择"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"投资金额选择"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 退出，确定
- (IBAction)quit:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)OK:(UIBarButtonItem *)sender {
    //1. 判断输入金额是否符合要求
    BOOL isApproval = [self isTheAmountOfInvestmentApprovalWithMoney:self.inputView.text];
    if (!isApproval) {
        return ;
    }
    
    //2 判断跟投还是领头
    if (self.isLingtou) {
        //领头
        
        //3 上传金额给服务器
        //参数
        NSString *userID = [BTNetWorking getUserInfoWithKey:@"userID"];
        NSDictionary *dic = @{@"method":@"firstInvest",@"user_id":userID,@"project_id":self.projectID,@"invest_money":self.inputView.text};
        [BTNetWorking getDataWithPara:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            NSString *res = [[[responseObject objectForKey:@"value"]firstObject] objectForKey:@"resCode"];
            if ([res isEqualToString:@"0"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"保存数据成功，等待后台审核！";
                [hud hide:YES afterDelay:1];
                hud.completionBlock = ^(){
                    [self.view endEditing:YES];
                    [self dismissViewControllerAnimated:YES completion:NULL];
                };
            }
        } failure:NULL];
    }
    else{
        //跟投
        //3 上传金额给服务器
        //参数
        NSString *userID = [BTNetWorking getUserInfoWithKey:@"userID"];
        NSDictionary *dic = @{@"method":@"followInvest",@"user_id":userID,@"project_id":self.projectID,@"invest_money":self.inputView.text};
        [BTNetWorking getDataWithPara:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            NSString *res = [[[responseObject objectForKey:@"value"] firstObject] objectForKey:@"resCode"];
            if ([res isEqualToString:@"0"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"保存数据成功，等待后台审核！";
                [hud hide:YES afterDelay:1];
                hud.completionBlock = ^(){
                    [self dismissViewControllerAnimated:YES completion:NULL];
                };
            }
        } failure:NULL];
        
    }
    
}

#pragma mark - 判断金额
- (BOOL)isTheAmountOfInvestmentApprovalWithMoney:(NSString *)money{
    NSNumber *max = [NSNumber numberWithInt:500];
    NSNumber *min = [NSNumber numberWithInt:100];
    NSNumber *number = [NSNumber numberWithInteger:[money integerValue]];
   
        if (!(number > min)) {
            //没有大于最小值
            [BTIndicator showForkMarkOnView:self.view withText:@"投资金额不能低于最低金额" withDelay:1];
            return NO;
        }
        else if (!(number < max))
        {
            //没有小雨最大值
            [BTIndicator showForkMarkOnView:self.view withText:@"投资金额不能高于最高金额" withDelay:1];
            return NO;
        }
        else if ([number intValue]  % [min intValue] != 0)
        {
            //不是n的整数倍
            [BTIndicator showForkMarkOnView:self.view withText:@"投资金额必须为最低金额整数倍" withDelay:1];
            return NO;
        }
        else {
            return YES;
        }
    
    
        
}

@end


