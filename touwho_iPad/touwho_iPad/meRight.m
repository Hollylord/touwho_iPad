//
//  meRight.m
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "meRight.h"
#import "profileViewController.h"
#import "profile.h"
#import "ProgramsTableViewCell.h"
#import "FollowedSponsorTableViewCell.h"
#import "ModelMyProgram.h"


#import "apply.h"
#import "program2ViewController.h"
#import "ModelMyInstitution.h"

@interface meRight ()
///存放投资人的model数组
@property (strong,nonatomic) NSMutableArray *modelsSponsor;
///存放项目model数组
@property (strong,nonatomic) NSMutableArray *modelsPrograms;
///存放models的数组
@property (strong,nonatomic) NSMutableArray *models;
@end

@implementation meRight
{
    UITableView *institutionTableView;
    UITableView *investedProgramsTableView;
//    UITableView *publishedProgramsTableView;
//    UITableView *followedProgramsTableView;
    UITableView *followedSponsorTableview;
 
}
#pragma mark - 懒加载
- (NSMutableArray *)modelsSponsor{
    if (!_modelsSponsor) {
        _modelsSponsor = [NSMutableArray array];
    }
    return _modelsSponsor;
}
- (NSMutableArray *)modelsPrograms{
    if (!_modelsPrograms) {
        _modelsPrograms = [NSMutableArray array];
    }
    return _modelsPrograms;
}

#pragma mark - meleft代理
#pragma mark 编辑个人信息页面的设置
- (void)presentProfileWithSender:(meLeft *)sender{
    [TalkingData trackEvent:@"编辑个人信息"];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    profile *view = [[[NSBundle mainBundle] loadNibNamed:@"profile" owner:nil options:nil]firstObject];
    view.leftView = sender;
    [self addSubview:view];
    [self layoutForSubview:view];
    
    //设置拍到照片后的回调方法：显示图片
    profileViewController *VC = (profileViewController *)[self viewController];
    VC.presentBusinessCard = ^(UIImage * image){
        [view.businessCard setImage:image];
        
    };
    
}

#pragma mark 申请为领投人
- (void)presentApply{
    [TalkingData trackEvent:@"申请领头资格"];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    apply *view = [[[NSBundle mainBundle] loadNibNamed:@"apply" owner:nil options:nil]firstObject];
    view.isLingtou = YES;
    [self addSubview:view];
    [self layoutForSubview:view];
    
    //修改数据
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xinwen" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    view.serviceContentView.text = [dic objectForKey:@"lingtourenxieyi"];
}

#pragma mark 申请为投资人
- (void)presentSponsor{
    [TalkingData trackEvent:@"申请跟投资格"];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    apply *view = [[[NSBundle mainBundle] loadNibNamed:@"apply" owner:nil options:nil]firstObject];
    view.isLingtou = NO;
    [self addSubview:view];
    [self layoutForSubview:view];
    
    //修改数据
    [view.enterpriseIdentify removeFromSuperview];
    [view.protocolLabel setText:@"《跟投人服务协议》"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xinwen" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    view.serviceContentView.text = [dic objectForKey:@"gentourenxieyi"];
}

#pragma mark 发布项目
- (void)presentPublish{
    [TalkingData trackEvent:@"发布项目"];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"publish" owner:nil options:nil]firstObject];
    [self addSubview:view];
    [self layoutForSubview:view];
    
}

#pragma mark 已投资的项目
- (void)presentPrograms{
    [TalkingData trackEvent:@"查看已投资的项目"];
    
    //获取以投资的项目数据
    [self retriveDataFromServerWithMethod:@"myInvesteProject" andCompletionBlock:^{
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        UITableView *programs = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        
        investedProgramsTableView = programs;
        programs.delegate = self;
        programs.dataSource = self;
        
        [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
        [self addSubview:programs];
        [self layoutForSubview:programs];
        
        //添加一个白色的遮盖
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        [self layoutForWhiteView:whiteView andTopDistance:self.modelsPrograms.count * 200];
        
    }];
    
    
}

#pragma mark 已发布的项目
- (void)presentPublished{
    [TalkingData trackEvent:@"查看已发布的项目"];
    
    //获取已发布的项目的数据
    [self retriveDataFromServerWithMethod:@"myBuildProject" andCompletionBlock:^{
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        UITableView *programs = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        programs.delegate = self;
        programs.dataSource = self;
        [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
        [self addSubview:programs];
        [self layoutForSubview:programs];
        
        //添加一个白色的遮盖
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        [self layoutForWhiteView:whiteView andTopDistance:self.modelsPrograms.count * 200];
        
    }];
    
    
    
    
}

//#pragma mark 关注的项目
//- (void)presentFollowedProgram{
//    [self retriveDataFromServerWithMethod:@"myFollowProject" andCompletionBlock:^{
//        
//        for (UIView *view in self.subviews) {
//            [view removeFromSuperview];
//        }
//        
//        UITableView *programs = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
//        
//        programs.delegate = self;
//        programs.dataSource = self;
//        [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
//        [self addSubview:programs];
//        [self layoutForSubview:programs];
//    }];
//    
//    
//}
//
//#pragma mark 关注的机构
//- (void)presentFollowedInstitution{
//    
//    [self retriveInstitustionDataFromServerWithCompletionBlock:^{
//        
//        for (UIView *view in self.subviews) {
//            [view removeFromSuperview];
//        }
//        
//        UITableView *institution = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
//        institutionTableView = institution;
//        institution.delegate = self;
//        institution.dataSource = self;
//        [institution registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
//        [self addSubview:institution];
//        [self layoutForSubview:institution];
//    }];
//    
//    
//}
//
//#pragma mark 关注的投资人
//- (void)presentFollowedSponsor{
//    for (UIView *view in self.subviews) {
//        [view removeFromSuperview];
//    }
//    
//    UITableView *followedSponsor = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
//    followedSponsorTableview = followedSponsor;
//    followedSponsor.delegate = self;
//    followedSponsor.dataSource = self;
//    [followedSponsor registerNib:[UINib nibWithNibName:@"FollowedSponsorCell" bundle:nil] forCellReuseIdentifier:@"FollowedSponsorCell"];
//    [self addSubview:followedSponsor];
//    [self layoutForSubview:followedSponsor];
//}

#pragma mark 消息
- (void)presentMessage{
    [TalkingData trackEvent:@"查看消息"];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    privateMessage *view = [[[NSBundle mainBundle] loadNibNamed:@"privateMessage" owner:nil options:nil]firstObject];
    self.messageView = view;
    //传递数据
    view.conversations = self.conversations;
    [self addSubview:view];
    [self layoutForSubview:view];
    
}

#pragma mark 布局
- (void)layoutForSubview:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.superview layoutIfNeeded];

}
- (void) layoutForWhiteView:(UIView *)view andTopDistance:(CGFloat)dis{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:20 + dis];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [view.superview addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.superview layoutIfNeeded];
}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //关注的投资人
    if (tableView == followedSponsorTableview) {
        return 2;
    }
    else if (tableView == institutionTableView){
        return self.models.count;
    }
    else {
        //我的项目
        return self.modelsPrograms.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //关注的投资人tableview
    if ([tableView isEqual:followedSponsorTableview]) {
        FollowedSponsorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowedSponsorCell" forIndexPath:indexPath];
        
        return cell;
    }
    //关注的机构机构
    else if ([tableView isEqual:institutionTableView]){
        ProgramsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
        cell.model_b = self.models[indexPath.row];
        
        return cell;
    }
    //项目tableview 3个
    else{
        ProgramsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
        cell.model = self.modelsPrograms[indexPath.row];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //投资人tableview
    if ([tableView isEqual:followedSponsorTableview]) {
        
    }
    else if ([tableView isEqual:institutionTableView]){
        
    }
    //项目tableview 3个
    else if ([tableView isEqual:investedProgramsTableView]){
        UIViewController *VC = [self viewController];
        program2ViewController *programVC = [[program2ViewController alloc] initWithNibName:@"program2ViewController" bundle:nil];
        //传递数据
        NSDictionary *model = [[self.modelsPrograms objectAtIndex:indexPath.row] keyValues];
        programVC.model1 = [ModelForProgramView mj_objectWithKeyValues:model];
        [VC.navigationController pushViewController:programVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //我关注的投资人
    if (tableView == followedSponsorTableview) {
        return 100;
    } else {
        return 200;
    }
  
}

//获得当前view的控制器
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 获取网络数据
///获取项目数据
- (void)retriveDataFromServerWithMethod:(NSString *)method andCompletionBlock:(void(^)())block {
    //参数
    NSDictionary *para = @{@"method":method,@"user_id":USER_ID};
    
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            //json数组 --> model数组
            self.modelsPrograms = [ModelMyProgram mj_objectArrayWithKeyValuesArray:jsonArr];
            
        }];
        
        
        
        block();
   
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

///获取机构数据
//- (void) retriveInstitustionDataFromServerWithCompletionBlock:(void(^)())block{
//    //参数
//    NSDictionary *para = @{@"method":@"myFollowOrganization",@"user_id":USER_ID};
//    
//    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//        NSArray *programs = [responseObject objectForKey:@"value"];
//
//        //json数组 --> model数组
//        self.models = [ModelMyInstitution mj_objectArrayWithKeyValuesArray:programs];
//        
//        block();
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"%@",error);
//    }];
//
//}
@end
