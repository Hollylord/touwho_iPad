//
//  SpecificGroupViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/14.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "SpecificGroupViewController.h"
#import "SpecificTopicViewController.h"
#import "TopicCell.h"

@interface SpecificGroupViewController () <UITableViewDataSource,UITableViewDelegate>

//存放所有话题model
@property (strong,nonatomic) NSMutableArray *topicsArr;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

///小组icon
@property (weak, nonatomic) IBOutlet UIImageView *groupIcon;
///小组名称
@property (weak, nonatomic) IBOutlet UILabel *groupName;
///小组简介
@property (weak, nonatomic) IBOutlet UILabel *groupIntroduction;
///组长昵称
@property (weak, nonatomic) IBOutlet UILabel *leaderName;
///成员个数
@property (weak, nonatomic) IBOutlet UILabel *memberCount;



@end

@implementation SpecificGroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
 
    
    //添加已有的数据数据
    NSString *logo = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.model.mLogo];
    [self.groupIcon sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    self.groupName.text = self.model.mName;
    self.leaderName.text = self.model.mGroupLeader;
    self.memberCount.text = self.model.mMemberCount;
    self.groupIntroduction.text = self.model.mDestrible;
    
    //获取数据
    [self pullGroupData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell" forIndexPath:indexPath];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //跳转到话题详情页面
    SpecificTopicViewController *topicVC = [[SpecificTopicViewController alloc] initWithNibName:@"SpecificTopicViewController" bundle:nil];
   
    [self.navigationController pushViewController:topicVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

#pragma mark - 分享
- (void)share{
    //用这个方法设置url跳转的网页，若是用自定义分享界面则设置全部url不行
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:@"http://www.baidu.com"];
    //设置分享的 title
    [UMSocialData defaultData].title = @"回音必项目分享";
    
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self.splitViewController
                                         appKey:@"5602081a67e58ec377001b17"
                                      shareText:@""
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina]
                                       delegate:nil];
    
    
    
}

#pragma mark - 获取数据
- (void)pullGroupData{
    NSLog(@"%@",self.model.mID);
    //参数
    NSDictionary *para = @{@"method":@"getDetailGroup",@"group_id":self.model.mID};
    
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - 加入/退出小组
- (IBAction)joinOrQuit:(UIButton *)sender {
    //没有登录则提示登录
    if (!USER_ID) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请登录后再试";
        [hud hide:YES afterDelay:1];
        return ;
    }
    
    //加入
    if (!sender.selected) {
        NSDictionary *para = @{@"method":@"addGroup",@"group_id":self.model.mID,@"user_id":USER_ID};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            sender.selected = !sender.selected;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    //退出
    else{
        NSDictionary *para = @{@"method":@"exitGroup",@"group_id":self.model.mID,@"user_id":USER_ID};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            sender.selected = !sender.selected;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

@end
