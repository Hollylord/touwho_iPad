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
#import "ModelForSponsor.h"
#import "LingTouViewController.h"
#import "OtherCenterViewController.h"
#import "ModelProgramDetails.h"

typedef void(^dataBlock)(ModelProgramDetails *model);

@interface program2ViewController () <UITableViewDataSource,UITableViewDelegate>

//子视图
@property (weak, nonatomic) IBOutlet UIView *program;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextView *textView3;

//@property (strong,nonatomic) ModelProgramDetails *modelDetail;

//用来装所有LP投资人Cell的模型的数组
@property (strong,nonatomic) NSMutableArray *LPArray;
//用来装所有GP投资人Cell的模型的数组
@property (strong,nonatomic) NSMutableArray *GPArray;



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

    
}
//控制器的子视图更新约束(添加一些新视图的约束)
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
    NSDictionary *para;
    NSString *userID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] objectForKey:@"userID"];
    if (userID) {
        //用户已登录
        para = @{@"method":@"getDetailProject",@"user_id":userID,@"project_id":self.model1.mID};
    }
    else{
        para = @{@"method":@"getDetailProject",@"project_id":self.model1.mID};
    }
    
    //获取数据
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //去掉菊花
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //json --> model
        NSDictionary *dic = [[responseObject objectForKey:@"value"] objectAtIndex:0];
        ModelProgramDetails *model = [ModelProgramDetails objectWithKeyValues:dic];
        
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
//        return self.GPArray.count;
        return 2;
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
//        cell.model = self.GPArray[indexPath.row];
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
    ModelForSponsor *model = self.LPArray[indexPath.row];
    //没有创建model会使得指针指向nil，数据传递不过去
    sponsor.model = [[modelForOtherVC alloc] init];
    sponsor.model.nickName = model.name;
    sponsor.model.image = model.image;
    
    [self.navigationController pushViewController:sponsor animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark - 按钮点击
- (IBAction)lingtouClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"领投" message:@"请在个人中心页面申请领头人资格" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:NULL];
    
}

- (IBAction)gentouClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"跟投" message:@"请在个人中心页面申请跟投人资格" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
    [alert addAction:OK];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"已申请" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LingTouViewController *lingVC = [[LingTouViewController alloc] initWithNibName:@"LingTouViewController" bundle:nil];
        lingVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:lingVC animated:YES completion:NULL];
    }];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:NULL];
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

#pragma mark - 关注

- (IBAction)followTheProgram:(UIButton *)sender {
    sender.selected = !sender.selected;
    //加关注
    if (sender.selected) {
        
        NSString *title = @"已关注";
        [sender setTitle:title forState:!sender.state];
    }
    //取消关注
    else{
        
        NSString *title = @"关注";
        [sender setTitle:title forState:!sender.state];
    }
}
@end
