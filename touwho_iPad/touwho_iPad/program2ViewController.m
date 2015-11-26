//
//  program2ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/2.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "program2ViewController.h"
#import "programView.h"
#import "sponsorTableViewCell.h"
#import "LingTouViewController.h"
#import "OtherCenterViewController.h"
#import "shipinViewController.h"

#import "ModelProgramDetails.h"
#import "ModelSponsors.h"

typedef void(^dataBlock)(ModelProgramDetails *model);

@interface program2ViewController () <UITableViewDataSource,UITableViewDelegate>

//子视图
@property (weak, nonatomic) IBOutlet UIView *program;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextView *textView3;
///发起人头像
@property (weak, nonatomic) IBOutlet UIImageView *initiatorheadIcon;
///发起人名字
@property (weak, nonatomic) IBOutlet UILabel *initiatorName;
///发起人二维码
@property (weak, nonatomic) IBOutlet UIImageView *initiatorQR;
///关注按钮
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
///详情model
@property (strong,nonatomic) ModelProgramDetails *modelDetail;

///用来装所有LP投资人Cell的模型的数组
@property (strong,nonatomic) NSMutableArray *LPArray;
///用来装所有GP投资人Cell的模型的数组
@property (strong,nonatomic) NSMutableArray *GPArray;
///用来装发起人Cell的模型的数组
@property (strong,nonatomic) NSMutableArray *initiatorsArray;
///是否为GP
@property (assign,nonatomic) BOOL isGP;
///是否为LP
@property (assign,nonatomic) BOOL isLP;


//按钮点击
- (IBAction)lingtouClick:(UIButton *)sender;
- (IBAction)gentouClick:(UIButton *)sender;
- (IBAction)followTheProgram:(UIButton *)sender;
@end

@implementation program2ViewController
{
    CGFloat height1;//textView1高度
    CGFloat height2;//textView2高度
    CGFloat height3;//textView3高度
    AFHTTPRequestOperationManager *mgr;
    
}

#pragma mark - 懒加载
- (NSMutableArray *)LPArray{
    if (!_LPArray) {
        _LPArray = [NSMutableArray array];
    }
    return  _LPArray;
}
- (NSMutableArray *)GPArray{
    if (!_GPArray) {
        _GPArray = [NSMutableArray array];
    }
    return _GPArray;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建加载数据的AFN
    mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

    //添加programView视图
    programView *view = (programView *)self.program;
    view.model = self.model1;
 
    
    //注册tableviewCell
    [self.tableView registerNib:[UINib nibWithNibName:@"sponsorCell" bundle:nil] forCellReuseIdentifier:@"sponsorCell"];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //判断用户是否有领投，跟投资格
    [BTNetWorking isQualifiedWithUserID:USER_ID withResults:^(BOOL isFirstInvestor, BOOL isInvestor) {
        self.isGP = isFirstInvestor;
        self.isLP = isInvestor;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //1.loading菊花
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //2.加载数据
    [self getData:^(ModelProgramDetails *model) {
        //3. 显示数据
        self.textView1.text = model.mSummary;
        self.textView2.text = model.mSuggest;
        self.textView3.text = model.mScheme;
        
        if ([model.mFollowStatus isEqualToString:@"0"]) {
            //未关注
            self.followBtn.selected = NO;
        }
        else{
            self.followBtn.selected = YES;
        }
        
        //显示发起人
        ModelSponsors *initiator = [self.initiatorsArray firstObject];
        NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,initiator.mAvatar];
        [self.initiatorheadIcon sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
//        NSString *QRURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mQRUrl];
//        [self.initiatorQR sd_setImageWithURL:[NSURL URLWithString:QRURL] placeholderImage:[UIImage imageNamed:@"logo_background"]];
        self.initiatorName.text = initiator.mName;
        
        //显示LP GP
        [self.tableView reloadData];
        
        //4. 调整布局
        //计算textView高度
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        height1 = [self calculateHeightForTextViewWithView:self.textView1 andAttributes:attr];
        height2 = [self calculateHeightForTextViewWithView:self.textView2 andAttributes:attr];
        height3 = [self calculateHeightForTextViewWithView:self.textView3 andAttributes:attr];
        
        //更改textView的约束
        [self adjustConstraintWithView:self.textView1 andIdentifier:@"textView1Height" andValue:height1];
        [self adjustConstraintWithView:self.textView2 andIdentifier:@"textView2Height" andValue:height2];
        [self adjustConstraintWithView:self.textView3 andIdentifier:@"textView3Height" andValue:height3];
        
        //刷新约束
        [self.scrollView setNeedsUpdateConstraints];
        
    }];

    [TalkingData trackPageBegin:@"项目详情"];
}

- (void)viewDidDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"项目列表"];
}
- (void)updateViewConstraints{
    
    [super updateViewConstraints];

}

- (void)layoutForFollowBtn:(UIView *)view {
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-20];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    
    [view.superview addConstraints:@[trailing,top]];
    view.translatesAutoresizingMaskIntoConstraints = NO;

}

#pragma mark - 获取数据
- (void)getData:(dataBlock)completionBlock{
    //设置参数
    NSDictionary *para = @{@"method":@"getDetailProject",@"user_id":USER_ID,@"project_id":self.model1.mID};
    
    
    //获取数据
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //去掉菊花
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",responseObject);
        
        //json --> model
        NSDictionary *dic = [[responseObject objectForKey:@"value"] objectAtIndex:0];
        ModelProgramDetails *model = [ModelProgramDetails objectWithKeyValues:dic];
        self.modelDetail = model;
        
        self.initiatorsArray = [ModelSponsors objectArrayWithKeyValuesArray:model.mLeaderInvestor];
        self.LPArray = [ModelSponsors objectArrayWithKeyValuesArray:model.mFollowInvestor];
        self.GPArray = [ModelSponsors objectArrayWithKeyValuesArray:model.mFirstInvestor];
        
        completionBlock(model);
    } failure:NULL];
    
    

}

//计算textview的高度
- (CGFloat)calculateHeightForTextViewWithView:(UITextView *)view andAttributes:(NSDictionary *)dic{
    CGSize viewSize = [view.text boundingRectWithSize:CGSizeMake(view.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return viewSize.height + 20;
}

- (void)adjustConstraintWithView:(UITextView *)view andIdentifier:(NSString *)identifier andValue:(CGFloat)value{
    for (NSLayoutConstraint *constraint in view.constraints) {
        if ([constraint.identifier isEqualToString:identifier]) {
            constraint.constant = value;
        }
    }
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.GPArray.count;
//        return 2;
    }
    else{
        return self.LPArray.count;
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"意向领投人";
    }
    else{
        return @"意向跟投人";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    sponsorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sponsorCell" forIndexPath:indexPath];
    //GP
    if (indexPath.section == 0) {
        cell.identityIMG.hidden = NO;
        cell.model = self.GPArray[indexPath.row];
        return cell;
    }
    //LP
    else
    {
        cell.model = self.LPArray[indexPath.row];
        return cell;
    }
    
}

//跳转他人个人中心
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OtherCenterViewController *sponsor = [[OtherCenterViewController alloc] initWithNibName:@"OtherCenterViewController" bundle:nil];
    //传递数据
    //领投人
    if (indexPath.section == 0) {
        sponsor.model = self.GPArray[indexPath.row];
    }
    //跟投人
    else{
        sponsor.model = self.LPArray[indexPath.row];
    }
    
    [self.navigationController pushViewController:sponsor animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark - 领投/跟投
///意向领投
- (IBAction)lingtouClick:(UIButton *)sender {
    
    if (!self.isGP) {
        //不是GP
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请在个人中心页面申请领头人资格";
        [hud hide:YES afterDelay:1];
        return ;
    }
    
    //跳转 领投页面
    LingTouViewController *lingVC = [[LingTouViewController alloc] initWithNibName:@"LingTouViewController" bundle:nil];
    lingVC.isLingtou = YES;
    lingVC.projectID = self.model1.mID;
    lingVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:lingVC animated:YES completion:NULL];
    
}

///意向跟投
- (IBAction)gentouClick:(UIButton *)sender {
    if (!self.isLP) {
        //没有LP资格
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请在个人中心页面申请跟投人资格";
        [hud hide:YES afterDelay:1];
        return ;
    }
    
    //跳转跟头页面
    LingTouViewController *lingVC = [[LingTouViewController alloc] initWithNibName:@"LingTouViewController" bundle:nil];
    lingVC.isLingtou = NO;
    lingVC.projectID = self.model1.mID;
    lingVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:lingVC animated:YES completion:NULL];

    
}

#pragma mark - 观看路演视频
- (IBAction)watchVideo:(UIButton *)sender {
    shipinViewController *shipinVC = [[shipinViewController alloc] initWithNibName:@"shipinViewController" bundle:nil];
    shipinVC.footageURL = self.modelDetail.mVideo;
    [self.navigationController pushViewController:shipinVC animated:YES];
    
}

#pragma mark - 分享
- (void)share{

    
    //设置分享的左边的图片
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@",SERVER_URL,self.model1.mSmallImageUrl]];
    

    //设置分享的 title
    [UMSocialData defaultData].extConfig.wechatSessionData.title = self.model1.mTitle;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.model1.mTitle;
    //如果qq没有title则不能分享qq
    [UMSocialData defaultData].extConfig.qqData.title = self.model1.mTitle;
    NSLog(@"分享url=%@",self.modelDetail.mProjectUrl);
    //设置分享的跳转url
    [UMSocialData defaultData].extConfig.qqData.url = self.modelDetail.mProjectUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.modelDetail.mProjectUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.modelDetail.mProjectUrl;
    
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self.splitViewController
                                         appKey:@"5602081a67e58ec377001b17"
                                      shareText:self.model1.mDestrible
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina]
                                       delegate:nil];
    
    
    
}

//#pragma mark - 关注
//- (IBAction)followTheProgram:(UIButton *)sender {
//    
//    // 加关注/取消关注
//    if (sender.selected) {
//        //取消关注
//        [self cancelFollowedProject:^{
//            sender.selected = !sender.selected;
//        }];
//
//        
//    }
//    //加关注
//    else{
//        [self followProject:^{
//            sender.selected = !sender.selected;
//        }];
//       
//    }
//}
//- (void)cancelFollowedProject:(void(^)())completionBlock{
//    
//    //参数
//    NSDictionary *para = @{@"method":@"cancelFollowProject",@"user_id":USER_ID,@"project_id":self.model1.mID};
//    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//    
//        
//        completionBlock();
//        
//    } failure:NULL];
//}
//- (void)followProject:(void(^)())completionBlock{
//    //参数
//    NSDictionary *para = @{@"method":@"followProject",@"user_id":USER_ID,@"project_id":self.model1.mID};
//    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//        completionBlock();
//        
//    } failure:NULL];
//}


@end
