//
//  JiGouDetailViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/15.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "JiGouDetailViewController.h"

@interface JiGouDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UITextView *introduction;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (weak, nonatomic) IBOutlet UIImageView *logo2;
@property (weak, nonatomic) IBOutlet UILabel *name2;

@end

@implementation JiGouDetailViewController


- (ModelForJiGouUnit *)model{
    if (!_model) {
        _model = [[ModelForJiGouUnit alloc] init];
    }
    return _model;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //设置内容
    self.introduction.text = self.model.mDestrible;
    self.name1.text = self.model.mName;
    self.name2.text = self.model.mName;
    NSString *logo = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.model.mLogo];
    NSURL *url = [NSURL URLWithString:logo];
    [self.logo1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_background"]];
    [self.logo2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_background"]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TalkingData trackPageBegin:@"机构详情页"];
    
    //1. 获取数据
    NSDictionary *para = @{@"method":@"getOrganizationDetail",@"user_id":USER_ID,@"org_id":self.model.mID};
    
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *result = [[responseObject objectForKey:@"value"] firstObject];
        if (![[result objectForKey:@"resCode"] isEqualToString:@"0"]) {
            return ;
        }
        
        NSString *content = [result objectForKey:@"mContent"];
        NSString *isFollow = [result objectForKey:@"mIsFollow"];
        
        //2. 设置内容
        if ([isFollow isEqualToString:@"0"]) {
            self.followBtn.selected = NO;
        }
        
        self.contentView.text = content;
        self.contentView.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        [style setParagraphSpacing:2];
    
        NSDictionary *attr = @{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:18],NSParagraphStyleAttributeName:style};
        CGSize contentSize = [self.contentView.text boundingRectWithSize:CGSizeMake(578, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
        
        //3. 修改约束
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if ([constraint.identifier isEqualToString:@"heightOfContentView"]) {
                constraint.constant = contentSize.height + 20;
            }
        }
        [self.contentView setNeedsUpdateConstraints];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
   
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"机构详情页"];
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

#pragma mark - 关注
//- (IBAction)focus:(UIButton *)sender {
//    //1 没有登录提示登录
//    if (!USER_ID) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"请您登录后再试";
//        [hud hide:YES afterDelay:1];
//        return ;
//    }
//    
//    // 取消关注
//    if (sender.selected) {
//        
//        [self cancelFollowedProject:^{
//            sender.selected = !sender.selected;
//        }];
//        
//        
//    }
//    // 加关注
//    else{
//        [self followProject:^{
//            sender.selected = !sender.selected;
//        }];
//        
//    }
//    
//}
//
//- (void)cancelFollowedProject:(void(^)())completionBlock{
//    
//    //参数
//    NSDictionary *para = @{@"method":@"followOrganization",@"user_id":USER_ID,@"org_id":self.model.mID};
//    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        completionBlock();
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"%@",error);
//    }];
//}
//
//- (void)followProject:(void(^)())completionBlock{
//    //参数
//    NSDictionary *para = @{@"method":@"cancelFollowOrganization",@"user_id":USER_ID,@"org_id":self.model.mID};
//    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        completionBlock();
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"%@",error);
//    }];
//}


@end
