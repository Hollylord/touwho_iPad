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

@property (strong,nonatomic) ModelForComment *modelComment;

@end

@implementation SpecificTopicViewController
{
    CGFloat heightTextView;
}
#pragma mark - 懒加载
- (ModelForTopic *)model{
    if (!_model) {
        _model = [[ModelForTopic alloc] init];
    }
    return _model;
}

- (ModelForComment *)modelComment{
    if (!_modelComment) {
        _modelComment = [[ModelForComment alloc] init];
    }
    return _modelComment;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //评论cell
    [self.tableView registerNib:[UINib nibWithNibName:@"commentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //新闻内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xinwen" ofType:@"plist"];
    NSDictionary *newsDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *content = [newsDic objectForKey:@"topic"];
    
    //根据内容设置新闻的高度
    self.contentTextView.text = content;
    self.contentTextView.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    
    heightTextView = [BTNetWorking calcutateHeightForTextviewWithFont:self.contentTextView.font andContent:content andWidth:516];
    
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    for (NSLayoutConstraint *constraint in self.contentTextView.constraints) {
        if ([constraint.identifier isEqualToString:@"heightTextView"]) {
            constraint.constant = heightTextView;
        }
    }
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
    
    cell.model = self.modelComment;
    
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
    sender.selected = !sender.selected;
}

#pragma mark - 私信
- (IBAction)sendMessage:(UIButton *)sender {
    
}

@end
