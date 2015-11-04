//
//  OtherCenterViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "OtherCenterViewController.h"
#import "FollowedSponsorTableViewCell.h"
#import "ProgramsTableViewCell.h"


@interface OtherCenterViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *headIconView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end

@implementation OtherCenterViewController
{
    UITableView *followedSponsorTableview;
 
    
    //用来存放模型的数组，这个数组的模型最后要给cell，所以要用全局变量
    NSMutableArray *arrayForSponsorModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    
    //注册cell
    UINib *nib = [UINib nibWithNibName:@"meLeftCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"meLeftCell"];
    
    //添加lastView
    UIView *rightView = [[UIView alloc] init];
    [self.view addSubview:rightView];
    [self layoutForSubview:rightView];
    
    //生成model 设置假数据
    //关注的项目model
    //关注的人model
    NSArray *name = @[@"杨伟鹏",@"郑慧文",@"袁泽平",@"赵妍昱",@"吴迪",@"吴萌",@"江泽民",];
    arrayForSponsorModel = [NSMutableArray array];
    for (int i = 0 ; i < 7; i ++) {
        SponsorModel *model = [[SponsorModel alloc] init];
        NSString *imageName = [NSString stringWithFormat:@"jigou%d",i];
        model.image = [UIImage imageNamed:imageName];
        model.name = name[i];
        
        [arrayForSponsorModel addObject:model];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.headIconView.image = self.model.image;
    self.nickNameLabel.text = self.model.nickName;
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview]) {
        return 5;
    }
    else{
        if (tableView == followedSponsorTableview) {
            
            return arrayForSponsorModel.count;
        }
        else{
            return 10;
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
            case 2:
                label.text = @"关注的项目";
                break;
            case 3:
                label.text = @"关注的机构";
                break;
            case 4:
                label.text = @"关注的投资人";
                break;
            default:
                break;
        }
        return cell;
    }
    //右边tableView
    else{
        //关注的投资人的tableview
        if (tableView == followedSponsorTableview) {
            FollowedSponsorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowedSponsorCell" forIndexPath:indexPath];
            cell.model = arrayForSponsorModel[indexPath.row];
            return cell;
        }
        //项目的tableview
        else {
            ProgramsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
         
            return cell;
        }
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    switch (indexPath.row) {
        case 0:
            [self presentPrograms];
            break;
        case 1:
            [self presentPublished];
            break;
        case 2:
            [self presentFollowedProgram];
            break;
        case 3:
            [self presentFollowedInstitution];
            break;
        case 4:
            [self presentFollowedSponsor];
            break;
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
    programs.delegate = self;
    programs.dataSource = self;
    [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self.view addSubview:programs];
    [self layoutForSubview:programs];
}
//关注的项目
- (void)presentFollowedProgram{
    UIView *lastSub = [self.view.subviews lastObject];
    [lastSub removeFromSuperview];
    
    UITableView *programs = [[UITableView alloc] init];
    
    programs.delegate = self;
    programs.dataSource = self;
    [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self.view addSubview:programs];
    [self layoutForSubview:programs];
}
//关注的机构
- (void)presentFollowedInstitution{
    UIView *lastSub = [self.view.subviews lastObject];
    [lastSub removeFromSuperview];
    
    UITableView *institution = [[UITableView alloc] init];
    
    institution.delegate = self;
    institution.dataSource = self;
    [institution registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self.view addSubview:institution];
    [self layoutForSubview:institution];
    
}

//关注的投资人
- (void)presentFollowedSponsor{
    UIView *lastSub = [self.view.subviews lastObject];
    [lastSub removeFromSuperview];
    
    UITableView *followedSponsor = [[UITableView alloc] init];
    followedSponsorTableview = followedSponsor;
    followedSponsor.delegate = self;
    followedSponsor.dataSource = self;
    [followedSponsor registerNib:[UINib nibWithNibName:@"FollowedSponsorCell" bundle:nil] forCellReuseIdentifier:@"FollowedSponsorCell"];
    [self.view addSubview:followedSponsor];
    [self layoutForSubview:followedSponsor];
}

- (void)layoutForSubview:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.tableview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:64];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.superview layoutIfNeeded];
    
}
@end
