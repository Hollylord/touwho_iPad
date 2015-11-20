//
//  ActivityDetailViewController.m
//  touwho_iPad
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "huodongViewController.h"
#import "ModelActivityDetail.h"

@interface ActivityDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityTime;
@property (weak, nonatomic) IBOutlet UILabel *activityContent;
///活动详情model
@property (strong,nonatomic) ModelActivityDetail *modelDetail;
@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    [self pullData:^{
        self.activityName.text = self.model.mTitle;
        self.activityTime.text = self.model.mTime;
        self.activityContent.text = self.modelDetail.mContent;
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [TalkingData trackPageBegin:@"活动详情页"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"活动详情页"];
}
#pragma mark - 获取数据
- (void) pullData:(dispatch_block_t)block{
    NSDictionary *para = @{@"method":@"getActivityDetail",@"activity_id":self.model.mID};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [[responseObject objectForKey:@"value"] firstObject];
        //json --> model
        self.modelDetail = [ModelActivityDetail objectWithKeyValues:dic];
        
        block();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - 跳转
- (IBAction)turnToNextVC:(UIButton *)sender {
    huodongViewController *nextVC = [[huodongViewController alloc] init];
    nextVC.model = self.model;
    [self.navigationController pushViewController:nextVC animated:YES];
}



@end
