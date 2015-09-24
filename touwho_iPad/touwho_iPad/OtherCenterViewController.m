//
//  OtherCenterViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "OtherCenterViewController.h"

@interface OtherCenterViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation OtherCenterViewController


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
    
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
        
        return cell;
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession]
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
