//
//  SpecificGroupViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/14.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "SpecificGroupViewController.h"
#import "SpecificTopicViewController.h"

@interface SpecificGroupViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *topics;//存放所有话题
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation SpecificGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell" forIndexPath:indexPath];

    
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
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession]
                                       delegate:nil];
    
    
    
}
@end
