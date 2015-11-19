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
#import "ModelGroupDetail.h"

@interface SpecificGroupViewController () <UITableViewDataSource,UITableViewDelegate>



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

@property (strong,nonatomic) ModelGroupDetail *modelDetail;

///存放话题model的数组
@property (strong,nonatomic) NSMutableArray *modelsTopic;
@end

@implementation SpecificGroupViewController

- (ModelGroupDetail *)modelDetail{
    if (!_modelDetail) {
        _modelDetail = [[ModelGroupDetail alloc] init];
    }
    return _modelDetail;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
 
    
    
    
    //获取数据
    [self pullGroupData:^{
        //添加已有的数据数据
        NSString *logo = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.modelDetail.mLogo];
        [self.groupIcon sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"logo_background"]];
        self.groupName.text = self.modelDetail.mName;
        self.leaderName.text = self.modelDetail.mGroupLeader;
        self.memberCount.text = self.modelDetail.mMemberCount;
        self.groupIntroduction.text = self.modelDetail.mDestrible;
        
        //刷新话题内容
        [self.tableview reloadData];
        
    }];
    
    
    
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
    
    return self.modelDetail.mTalks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell" forIndexPath:indexPath];
    
    cell.model = self.modelsTopic[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //跳转到话题详情页面
    SpecificTopicViewController *topicVC = [[SpecificTopicViewController alloc] initWithNibName:@"SpecificTopicViewController" bundle:nil];
    ModelForTopic *model = self.modelsTopic[indexPath.row];
    topicVC.model = model;
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
- (void)pullGroupData:(dispatch_block_t)block{
    
    //参数
    NSDictionary *para = @{@"method":@"getDetailGroup",@"group_id":self.model.mID};
    
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [[responseObject objectForKey:@"value"] firstObject];
        self.modelDetail = [ModelGroupDetail objectWithKeyValues:dic];
        
        self.modelsTopic = [ModelForTopic objectArrayWithKeyValuesArray:self.modelDetail.mTalks];
        
        block();
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
