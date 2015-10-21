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
@property (weak, nonatomic) IBOutlet UIImageView *groupIcon;
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UILabel *groupIntroduction;

@property (strong,nonatomic) ModelForTopic *modelTopic;
@end

@implementation SpecificGroupViewController
- (ModelForTopic *)modelTopic{
    if (!_modelTopic) {
        _modelTopic = [[ModelForTopic alloc] init];
    }
    return _modelTopic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //添加数据
    self.groupIcon.image = self.model.icon;
    self.groupName.text = self.model.name;
//    self.groupIntroduction.text = self.model.introduction;
    
    //添加话题数据
    self.modelTopic.publisher.icon = [UIImage imageNamed:@"jingwang"];
    self.modelTopic.publisher.nickName = @"悬镜司首尊夏江";
    self.modelTopic.title = @"江左盟宗主的真正目的";
    self.modelTopic.time = @"2015-10-10";
    self.modelTopic.content = @"遥映人间冰雪样，暗香幽浮曲临江，遍识天下英雄路，俯首江左有梅郎";
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
    
    cell.model = self.modelTopic;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //跳转到话题详情页面
    SpecificTopicViewController *topicVC = [[SpecificTopicViewController alloc] initWithNibName:@"SpecificTopicViewController" bundle:nil];
    topicVC.model = self.modelTopic;
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
@end
