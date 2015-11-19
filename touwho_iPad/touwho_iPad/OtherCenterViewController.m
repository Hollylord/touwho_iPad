//
//  OtherCenterViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/10.
//  Copyright © 2015年 touhu.com. All rights reserved.


#import "OtherCenterViewController.h"
#import "FollowedSponsorTableViewCell.h"
#import "ProgramsTableViewCell.h"
#import "ModelMyProgram.h"
#import "sixinViewController.h"


@interface OtherCenterViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *headIconView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
///已发布的项目models
@property (strong,nonatomic) NSMutableArray *modelsPublished;
///已投资的项目models
@property (strong,nonatomic) NSMutableArray *modelsInvested;

@end

@implementation OtherCenterViewController
{
    UITableView *publishedTableView;
    UITableView *investedTableView;
    BOOL isAlreadyPullPublishedData;
    BOOL isAlreadyPullInvestedData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    
    //注册cell
    UINib *nib = [UINib nibWithNibName:@"meLeftCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"meLeftCell"];
    
    //添加rightView
    UIView *rightView = [[UIView alloc] init];
    [self.view addSubview:rightView];
    [self layoutForSubview:rightView];
    
    //标志还没有获取数据
    isAlreadyPullInvestedData = NO;
    isAlreadyPullPublishedData = NO;
    
    
    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.model.mAvatar];
    [self.headIconView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    self.nickNameLabel.text = self.model.mName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TalkingData trackPageBegin:@"他人详情页"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"他人详情页"];
}
#pragma mark - 获取项目信息
- (void)pullInvestedData{
    if (isAlreadyPullInvestedData) {
        [self presentPrograms];
        return ;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //获取以投资的项目
    NSDictionary *para2 = @{@"method":@"myInvesteProject",@"user_id":self.model.mID};
    [BTNetWorking getDataWithPara:para2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        //json --> models
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            
            self.modelsInvested = [ModelMyProgram objectArrayWithKeyValuesArray:jsonArr];
        }];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isAlreadyPullInvestedData = YES;
        //显示数据
        [self presentPrograms];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

- (void)pullPublishedData{
    if (isAlreadyPullPublishedData) {
       [self presentPublished];
        return ;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //获取已发布的项目
    NSDictionary *para = @{@"method":@"myBuildProject",@"user_id":self.model.mID};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        
        //json --> models
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            
            self.modelsPublished = [ModelMyProgram objectArrayWithKeyValuesArray:jsonArr];
        }];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isAlreadyPullPublishedData = YES;
        
        [self presentPublished];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //左边的tableview
    if ([tableView isEqual:self.tableview]) {
        return 2;
    }
    //右边
    else{
        //已发布的项目
        if (tableView == publishedTableView) {
            
            return self.modelsPublished.count;
        }
        //以投资的项目
        else{
            return self.modelsInvested.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //左边tableView
    if ([tableView isEqual:self.tableview]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meLeftCell" forIndexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *label = (UILabel *)[cell viewWithTag:1];
        switch (indexPath.row) {
            case 0:
                label.text = @"已投资的项目";
                break;
            case 1:
                label.text = @"已发布的项目";
                break;
            default:
                break;
        }
        return cell;
    }
    //右边tableView
    else{
        ProgramsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
        //已投资的项目
        if ([tableView isEqual:investedTableView]) {
            cell.model = self.modelsInvested[indexPath.row];
        }
        else{
            cell.model = self.modelsPublished[indexPath.row];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
            //已投资的项目
            
            //获取这个用户的数据
            [self pullInvestedData];
            
            break;
        case 1:
            //已发布的项目
            
            //获取这个用户的数据
            [self pullPublishedData];
            
            
            break;
//        case 2:
//            [self presentFollowedProgram];
//            break;
//        case 3:
//            [self presentFollowedInstitution];
//            break;
//        case 4:
//            [self presentFollowedSponsor];
//            break;
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview]) {
        return 80;
    }
    else{
        return 150;
    }
    
}

#pragma mark - 分享
- (void)share{
    //用这个方法设置url跳转的网页，若是用自定义分享界面则设置全部url不行
    [UMSocialData defaultData].urlResource.url = @"http://www.baidu.com" ;
    
    //设置分享的左边的图片
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://img0.bdstatic.com/img/image/1f9ca4f74197091d203ca0edd6c4eee01410240322.jpg"];
    
    //设置分享的 title
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"回音必项目分享";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"回音必项目分享";
    [UMSocialData defaultData].extConfig.qqData.title = @"回音必项目分享";
    [UMSocialData defaultData].extConfig.qqData.url = @"www.baidu.com";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"www.baidu.com";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
    
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self.splitViewController
                                         appKey:@"5602081a67e58ec377001b17"
                                      shareText:@""
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina]
                                       delegate:nil];
    
    
    
}

#pragma mark - 点击tableViewCell
//已投资的项目
- (void)presentPrograms{
    UIView *lastSub = [self.view.subviews lastObject];
    [lastSub removeFromSuperview];
    
    UITableView *programs = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 605, self.view.bounds.size.height) style:UITableViewStylePlain];
    investedTableView = programs;
    programs.delegate = self;
    programs.dataSource = self;
    
    [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self.view addSubview:programs];
    [self layoutForSubview:programs];
    
}
//发起的项目
- (void)presentPublished{
    UIView *lastSub = [self.view.subviews lastObject];
    [lastSub removeFromSuperview];
    
    UITableView *programs = [[UITableView alloc] init];
    publishedTableView = programs;
    programs.delegate = self;
    programs.dataSource = self;
    [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self.view addSubview:programs];
    [self layoutForSubview:programs];
}
////关注的项目
//- (void)presentFollowedProgram{
//    UIView *lastSub = [self.view.subviews lastObject];
//    [lastSub removeFromSuperview];
//    
//    UITableView *programs = [[UITableView alloc] init];
//    
//    programs.delegate = self;
//    programs.dataSource = self;
//    [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
//    [self.view addSubview:programs];
//    [self layoutForSubview:programs];
//}
////关注的机构
//- (void)presentFollowedInstitution{
//    UIView *lastSub = [self.view.subviews lastObject];
//    [lastSub removeFromSuperview];
//    
//    UITableView *institution = [[UITableView alloc] init];
//    
//    institution.delegate = self;
//    institution.dataSource = self;
//    [institution registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
//    [self.view addSubview:institution];
//    [self layoutForSubview:institution];
//    
//}
//
////关注的投资人
//- (void)presentFollowedSponsor{
//    UIView *lastSub = [self.view.subviews lastObject];
//    [lastSub removeFromSuperview];
//    
//    UITableView *followedSponsor = [[UITableView alloc] init];
//    followedSponsorTableview = followedSponsor;
//    followedSponsor.delegate = self;
//    followedSponsor.dataSource = self;
//    [followedSponsor registerNib:[UINib nibWithNibName:@"FollowedSponsorCell" bundle:nil] forCellReuseIdentifier:@"FollowedSponsorCell"];
//    [self.view addSubview:followedSponsor];
//    [self layoutForSubview:followedSponsor];
//}

- (void)layoutForSubview:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.tableview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:64];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.superview layoutIfNeeded];
    
}

#pragma mark - 私信
- (IBAction)chatWithSomeone:(UIButton *)sender {
    if (!USER_ID) {
        [BTIndicator showForkMarkOnView:self.view withText:@"请登录后再试" withDelay:1];
        return ;
    }
    //创建长连接和会话: 将自己的id和朋友的id赋值
    [self openSessionByClientId:USER_ID navigationToIMWithTargetClientIDs:@[self.model.mID]];
    
}

- (void)openSessionByClientId:(NSString*)clientId navigationToIMWithTargetClientIDs:(NSArray *)clientIDs {
    [[LeanMessageManager manager] openSessionWithClientID:clientId completion:^(BOOL succeeded, NSError *error) {
        if(!error){
            
            
            ConversationType type;
            if(clientIDs.count>1){
                type=ConversationTypeGroup;
            }else{
                type=ConversationTypeOneToOne;
            }
            [[LeanMessageManager manager] createConversationsWithClientIDs:clientIDs conversationType:type completion:^(AVIMConversation *conversation, NSError *error) {
                if(error){
                    NSLog(@"error=%@",error);
                }else{
                    //保存数据coreData
                    [BTNetWorking setupCoreDataAndSaveConversation:conversation];
                    
                    sixinViewController *vc = [[sixinViewController alloc] initWithConversation:conversation];
                    vc.friendId = [clientIDs firstObject];
                    vc.modalPresentationStyle = UIModalPresentationFormSheet;
                    
                    //弹出回复控制器 界面
                    [self presentViewController:vc animated:YES completion:NULL];
                }
            }];
        }else{
            NSLog(@"error=%@",error);
        }
    }];
}

//存入coreData

@end
