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
    
    
    
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //1. 获取数据
    NSDictionary *para = @{@"method":@"getOrganizationDetail",@"user_id":USER_ID,@"org_id":self.model.mID};
    
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *result = [[responseObject objectForKey:@"value"] firstObject];
        if (![[result objectForKey:@"resCode"] isEqualToString:@"0"]) {
            return ;
        }
        NSDictionary *dic = [[result objectForKey:@"jsonArr"] firstObject];
        NSString *content = [dic objectForKey:@"mContent"];
        NSString *isFollow = [dic objectForKey:@"mIsFollow"];
        
        //2. 设置内容
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
- (IBAction)focus:(UIButton *)sender {
    
    
}

@end
