//
//  news2ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "news2ViewController.h"
#import "BDTTSSynthesizer.h"
#import "BDTTSSynthesizerDelegate.h"
#import <AFNetworking.h>


#define KtitleHeight 138
#define KreadLength 300

@interface news2ViewController () <BDTTSSynthesizerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfcontentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//正文
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *LectBtn;

@property (copy , nonatomic)  NSString * currentText;
@property (assign ,nonatomic) int numLength;
@property (assign ,nonatomic) int currentLength;





- (IBAction)dianZan:(UIButton *)sender;


@end

@implementation news2ViewController
{
    CGFloat height;
    UIImageView *imageView;
    CGSize imageSize;

}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.LectBtn.hidden = NO;
    self.playBtn.hidden = YES;
    // 初始化合成器
    [self initSynthesizer];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //新闻内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xinwen" ofType:@"plist"];
    NSDictionary *newsDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *content = [newsDic objectForKey:@"xinwen"];
    
    
    //根据内容设置新闻的高度
    self.contentView.text = content;
    
    self.contentView.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    [style setParagraphSpacing:2];
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:20],NSParagraphStyleAttributeName:style};
    NSStringDrawingOptions opts = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize textSize = [self.contentView.text boundingRectWithSize:CGSizeMake(800, MAXFLOAT) options:opts attributes:attribute context:nil].size;
    
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

#pragma mark - internal function
- (void)initSynthesizer
{
    [BDTTSSynthesizer setLogLevel:BDS_LOG_VERBOSE];
    
    // 设置合成器代理
    [[BDTTSSynthesizer sharedInstance] setSynthesizerDelegate: self];
    
    // 在线相关设置
    
    [[BDTTSSynthesizer sharedInstance] setApiKey:@"mheb5yGoOkbOihOikcOjhnt1" withSecretKey:@"b65db23549102b069a9e7851aaa18669"];
    [[BDTTSSynthesizer sharedInstance] setTTSServerTimeOut:10];
    
    
    // 合成参数设置
    [[BDTTSSynthesizer sharedInstance] setSynthesizeParam: BDTTS_PARAM_VOLUME withValue: BDTTS_PARAM_VOLUME_MAX];
    
    // 加载合成引擎
    [[BDTTSSynthesizer sharedInstance] loadTTSEngine];
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

-(void)viewWillDisappear:(BOOL)animated{
    
    [[BDTTSSynthesizer sharedInstance] cancel];
    
}


- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    self.heightOfcontentView.constant = height;
    
    if (imageView.image) {
        [self layoutForImageView:imageView imageSize:imageSize];
        
        //修改滚动范围
        for (NSLayoutConstraint *constraint in self.scrollView.constraints) {
            if ([constraint.identifier isEqualToString:@"contentSizeHeight"]) {
                constraint.constant = constraint.constant + imageSize.height/2;
            }
        }
        
    }
}

- (void)layoutForImageView:(UIImageView *)view imageSize:(CGSize)size{
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    
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



- (IBAction)playBtn:(UIButton *)sender {
    
    if (sender.selected == NO) {
        sender.selected = !sender.selected;
        [sender setBackgroundImage:[UIImage imageNamed:@"newsPause"] forState:UIControlStateNormal];
        [[BDTTSSynthesizer sharedInstance] pause];
        
    }else{
        sender.selected = !sender.selected;
        [sender setBackgroundImage:[UIImage imageNamed:@"newsLect"] forState:UIControlStateNormal];
        [[BDTTSSynthesizer sharedInstance] resume];
    }
}

- (IBAction)newsLect:(UIButton *)sender {
    
    
    if(sender.selected == NO)
    {
        sender.hidden = YES;
        self.playBtn.hidden = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"newsLectClose"] forState:UIControlStateNormal];
        self.numLength =(int) self.contentView.text.length;
        
        self.currentLength +=KreadLength;
        int readlength = KreadLength;
        
        if (self.numLength <  KreadLength) {
            readlength = self.numLength;
        }
        
        
        NSString * str = [self.contentView.text substringWithRange:NSMakeRange(0, readlength)];
        NSInteger ret = [[BDTTSSynthesizer sharedInstance] speak:str];
        if (ret != BDTTS_ERR_SYNTH_OK) {}
        
    }
    
}


-(void)synthesizerSpeechDidFinished{
    
    int readlength = KreadLength;
    int textlength = self.numLength - self.currentLength ;
    if ( textlength >= 0) { // 判断停止；
        
        if (textlength <= KreadLength) {
            readlength = textlength;
        }
        
        
        NSString * str = [self.contentView.text substringWithRange:NSMakeRange(self.currentLength, readlength)];
        [[BDTTSSynthesizer sharedInstance] speak:str];
        
        self.currentLength +=KreadLength;
        
    }else{
        
        self.playBtn.hidden = YES;
        self.LectBtn.hidden = NO;
        self.currentLength = 0;
        
    }
    
    
}


@end
