//
//  SpecificTopicViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/14.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "SpecificTopicViewController.h"
#import "replyViewController.h"
#import "CommentCell.h"
#import "ModelTopicDetail.h"
#import "ModelGroupDetail.h"


@interface SpecificTopicViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *iconGroup;
@property (weak, nonatomic) IBOutlet UIImageView *iconWriter;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leader;
@property (weak, nonatomic) IBOutlet UILabel *memberCount;

///存放话题详情的model
@property (strong,nonatomic)ModelTopicDetail *modelDetail;
///存放小组详情的model
@property (strong,nonatomic) ModelGroupDetail *modelGroup;

@end

@implementation SpecificTopicViewController

#pragma mark - 懒加载
- (ModelForTopic *)model{
    if (!_model) {
        _model = [[ModelForTopic alloc] init];
    }
    return _model;
}
- (ModelTopicDetail *)modelDetail{
    if (!_modelDetail) {
        _modelDetail = [[ModelTopicDetail alloc]init];
    }
    return _modelDetail;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //评论cell
    [self.tableView registerNib:[UINib nibWithNibName:@"commentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
    
    
    //获取详情
    [self pullData:^{
        //显示数据
        NSString *iconURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.modelGroup.mLogo];
        [self.iconGroup sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
        self.introductionLabel.text = self.modelGroup.mDestrible;
        self.groupNameLabel.text = self.modelGroup.mName;
        self.leader.text = self.modelGroup.mGroupLeader;
        self.memberCount.text = self.modelGroup.mMemberCount;
        
        self.timeLabel.text = self.model.mCreateTime;
        self.titleLabel.text = self.model.mTitle;
        
        
        self.contentTextView.text = self.modelDetail.mTalkContent;
        self.contentTextView.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
        
        //更新约束
        for (NSLayoutConstraint *constraint in self.contentTextView.constraints) {
            if ([constraint.identifier isEqualToString:@"heightTextView"]) {
                constraint.constant = [BTNetWorking calcutateHeightForTextviewWithFont:self.contentTextView.font andContent:self.modelDetail.mTalkContent andWidth:516];
            }
        }
        
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - 分享
- (IBAction)share:(id)sender {
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

#pragma mark - 评论
- (IBAction)remark:(id)sender {
    
    replyViewController *replyVC = [[replyViewController alloc] initWithNibName:@"replyViewController" bundle:nil];
    replyVC.modalPresentationStyle = UIModalPresentationFormSheet;
    //弹出回复控制器 界面
    [self presentViewController:replyVC animated:YES completion:NULL];

}
#pragma mark - 点赞
- (IBAction)thumbUp:(UIButton *)sender {
    
    if (![BTNetWorking isUserAlreadyLoginWithAlertView:self.view]) {
        return ;
    }
    
    //点赞
    if (!sender.selected) {
        NSDictionary *para = @{@"method":@"followTalk",@"user_id":USER_ID,@"talk_id":self.model.mID};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
          
            
            sender.selected = !sender.selected;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }
    //取消点赞
    else{
        NSDictionary *para = @{@"method":@"cancelFollowTalk",@"user_id":USER_ID,@"talk_id":self.model.mID};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            sender.selected = !sender.selected;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }
    
}

#pragma mark - 私信
- (IBAction)sendMessage:(UIButton *)sender {
    
}

#pragma mark - 获取data
- (void)pullData:(dispatch_block_t)block{
    //获取项目详情
    NSDictionary *para = @{@"method":@"getDetailTalk",@"talk_id":self.model.mID};
    NSMutableDictionary *para2 = [NSMutableDictionary dictionaryWithDictionary:para];
    [para2 setValue:USER_ID forKey:@"user_id"];

    [BTNetWorking getDataWithPara:para2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [[responseObject objectForKey:@"value"] firstObject];
        self.modelDetail = [ModelTopicDetail objectWithKeyValues:dic];
       
        
        
        //获取小组
        NSDictionary *para = @{@"method":@"getDetailGroup",@"group_id":self.modelDetail.mGroupID};
        
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"%@",responseObject);
            NSDictionary *dic = [[responseObject objectForKey:@"value"] firstObject];
            
            self.modelGroup = [ModelGroupDetail objectWithKeyValues:dic];
            
            block();
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

@end
