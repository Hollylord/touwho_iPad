//
//  news2ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "news2ViewController.h"
#import "BDSSpeechSynthesizer.h"
#import "BDSSpeechSynthesizerDelegate.h"
#import <AFNetworking.h>

@interface news2ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfArticle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//存放所有评论
@property (nonatomic ,strong) NSMutableArray * messages;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//正文
@property (weak, nonatomic) IBOutlet UITextView *article;

- (IBAction)dianZan:(UIButton *)sender;


@end

@implementation news2ViewController
{
    CGFloat height;
    UIImageView *imageView;
    CGSize imageSize;
}

- (NSMutableArray *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //语音合成设置
    BDSSpeechSynthesizer *synthesizer = [[BDSSpeechSynthesizer alloc] initSynthesizer:@"holder"delegate:nil];
    // 注：your-apiKey 和 your-secretKey 需要换成在百度开发者中心注册应用得到的对应值
    [synthesizer setApiKey:@"mheb5yGoOkbOihOikcOjhnt1" withSecretKey:@"b65db23549102b069a9e7851aaa18669"];
    //    [synthesizer speak:@"百度一下"];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //新闻内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xinwen" ofType:@"plist"];
    NSDictionary *newsDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *content = [newsDic objectForKey:@"xinwen"];
    
    
    //根据内容设置新闻的高度
    self.article.text = content;
    
    self.article.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:20],NSParagraphStyleAttributeName:style};
    NSStringDrawingOptions opts = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize textSize = [self.article.text boundingRectWithSize:CGSizeMake(800, MAXFLOAT) options:opts attributes:attribute context:nil].size;
    
    height = textSize.height + 20;
    
    //增加一张图片放在底部
    imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"advert3"];
    //image.size是以像素为单位的所以要换算成点
    imageSize = CGSizeMake(image.size.width/2, image.size.height/2);
    imageView.image = image;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    self.heightOfArticle.constant = height;
    
    if (imageView.image) {
        NSLog(@"%@",NSStringFromCGSize(imageSize));
        [self layoutForImageView:imageView imageSize:imageSize];
        
        //修改滚动范围
        for (NSLayoutConstraint *constraint in self.scrollView.constraints) {
            if ([constraint.identifier isEqualToString:@"contentSizeHeight"]) {
                constraint.constant = constraint.constant + imageSize.height/2;
                NSLog(@"%f",imageSize.height);
            }
        }
        
    }
    
    

}
- (void)layoutForImageView:(UIImageView *)view imageSize:(CGSize)size{
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.article attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.width];
    NSLayoutConstraint *heigh = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.height];
    [view.superview addConstraints:@[centerX,top]];
    [view addConstraints:@[width,heigh]];
    view.translatesAutoresizingMaskIntoConstraints = NO;

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
#pragma mark - 按钮点击
//点赞
- (IBAction)dianZan:(UIButton *)sender {
    sender.selected = !sender.selected;
}
@end
