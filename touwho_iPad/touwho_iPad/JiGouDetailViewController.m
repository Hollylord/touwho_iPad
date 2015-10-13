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
{
    CGFloat heightContentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //设置内容假数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xinwen" ofType:@"plist"];
    self.contentView.text = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"shunfeng"];
    self.contentView.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    [style setParagraphSpacing:2];
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:18],NSParagraphStyleAttributeName:style};
    CGSize contentSize = [self.contentView.text boundingRectWithSize:CGSizeMake(578, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    heightContentView = contentSize.height + 20;
    
}
- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    //设置contentView的高度
    for (NSLayoutConstraint *constraint in self.contentView.constraints) {
        if ([constraint.identifier isEqualToString:@"heightOfContentView"]) {
            constraint.constant = heightContentView;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession]
                                       delegate:nil];
    
    
    
}
#pragma mark - 关注
- (IBAction)focus:(UIButton *)sender {
}

@end
