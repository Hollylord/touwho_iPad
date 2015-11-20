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

//定义了一个block类型 叫completionBlock
typedef void(^completionBlock)(NSString *content,NSString *ispraised,NSString *largeImageUrl,NSString *bottomImageUrl);

@interface news2ViewController () <BDTTSSynthesizerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfcontentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//正文
@property (weak, nonatomic) IBOutlet UITextView *contentView;
//时间label
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
///上图
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *LectBtn;

@property (copy , nonatomic)  NSString * currentText;
@property (assign ,nonatomic) int numLength;
@property (assign ,nonatomic) int currentLength;

@property (strong,nonatomic) AFNetworkReachabilityManager *netWorkMgr;



- (IBAction)dianZan:(UIButton *)sender;


@end

@implementation news2ViewController
{
    CGFloat height;
    UIImageView *imageView;
    CGSize imageSize;
    AFHTTPRequestOperationManager *mgr;
    NSString *userID;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.LectBtn.hidden = NO;
    self.playBtn.hidden = YES;
    
    // 初始化合成器
    [self initSynthesizer];
    
    //监听网络
    [self startNetWorkMonitor];
    
    //创建AFN
    mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    //添加全局变量
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    userID = [user objectForKey:@"userID"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TalkingData trackPageBegin:@"新闻详情"];
    
    //添加时间和title
    self.timeLabel.text = self.model.time;
    self.titleLabel.text = self.model.title;
    
    //加载网络新闻内容
    [self getData:^(NSString *content, NSString *ispraised, NSString *largeImageUrl, NSString *bottomImageUrl) {
        
        if ([largeImageUrl isEqualToString:@""]) {
            //没有上图
            [self.topImageView removeFromSuperview];
        }
        else{
            NSString *top = [NSString stringWithFormat:@"%@%@",SERVER_URL,largeImageUrl];
            [self.topImageView sd_setImageWithURL:[NSURL URLWithString:top] placeholderImage:[UIImage imageNamed:@"logo_background"]];
        }
        
        
        //拿到获取的网络数据
        self.contentView.text = content;
        
        //根据内容设置新闻的高度
        self.contentView.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        [style setParagraphSpacing:2];
        
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:20],NSParagraphStyleAttributeName:style};
        NSStringDrawingOptions opts = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        
        CGSize textSize = [self.contentView.text boundingRectWithSize:CGSizeMake(800, MAXFLOAT) options:opts attributes:attribute context:nil].size;
        
        height = textSize.height + 20;
        
        //根据是否已经被点赞了来选择点赞按钮的状态
        if ([ispraised isEqualToString:@"0"]) {
            //没有点赞
            self.followBtn.selected = NO;
            
        }
        else{
            self.followBtn.selected = YES;
        }
        
        
        
        //增加一张图片放在底部
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *bottom = [NSString stringWithFormat:@"%@%@",SERVER_URL,bottomImageUrl];
        NSURL *url = [NSURL URLWithString:bottom];
        [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //image.size是以像素为单位的所以要换算成点
            imageSize = CGSizeMake(image.size.width, image.size.height);
            [self.scrollView addSubview:imageView];
            [self.scrollView setNeedsUpdateConstraints];
        }];
        
        
    }];
    
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[BDTTSSynthesizer sharedInstance] cancel];
    
    [TalkingData trackPageEnd:@"新闻详情"];
}

//如果往控制的view上添加了子控件，那么setNeeds回来这里。如果只是改变原来子控件的约束，则不会来。
- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    self.heightOfcontentView.constant = height;
    
    if (imageView.image) {
        [self layoutForImageView:imageView imageSize:imageSize];
        
        //修改滚动范围
        for (NSLayoutConstraint *constraint in self.scrollView.constraints) {
            if ([constraint.identifier isEqualToString:@"contentSizeHeight"]) {
                constraint.constant = constraint.constant + imageSize.height;
            }
        }
        
    }
}

#pragma mark - 初始化
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

//开启网络状态监听
- (void)startNetWorkMonitor{
    AFNetworkReachabilityManager *netWorkMgr = [AFNetworkReachabilityManager sharedManager];
    self.netWorkMgr = netWorkMgr;
    [self.netWorkMgr startMonitoring];
    
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


#pragma mark - 加载网络数据
- (void)getData:(completionBlock)complete{
    
    NSString *mId = self.model.mId;
    
    
    //设置参数
    NSDictionary *para;
    if (!userID) {
        para = @{@"method":@"getNewsContent",@"news_id":mId};
    }
    else{
        para = @{@"method":@"getNewsContent",@"news_id":mId,@"user_id":userID};
    }
    
    
    
    //加载数据
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *temp = [responseObject objectForKey:@"value"];
        NSDictionary *dic = [temp firstObject];
        NSString *content = [dic objectForKey:@"mContent"];
        NSString *isPraised = [dic objectForKey:@"mIsPraise"];
        NSString *mBottomImageUrl = [dic objectForKey:@"mBottomImageUrl"];
        NSString *mLargeImageUrl = [dic objectForKey:@"mLargeImageUrl"];

        complete(content,isPraised,mLargeImageUrl,mBottomImageUrl);
        
    } failure:NULL];
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

#pragma mark - 按钮点击
//点赞
- (IBAction)dianZan:(UIButton *)sender {
    //1.判断是否已登录，没有登录提示用户登录；登录之后才有资格点赞
    if (!userID) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ForkMark"]];
        hud.mode = MBProgressHUDModeCustomView;
        
        hud.labelText = @"您尚未登录。请登录后点赞";
        [hud hide:YES afterDelay:1];
        return ;
    }
    
    //2. 判断是要点赞，还是取消点赞
    if (!sender.selected) {
        //点赞
        NSDictionary *para = @{@"method":@"praiseNews",@"news_id":self.model.mId,@"user_id":userID};
        [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
           NSString *resCode = [[responseObject objectForKey:@"value"] objectForKey:@"resCode"];
            if ([resCode isEqualToString:@"0"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"点赞成功";
                [hud hide:YES afterDelay:0.5];
                
                //更改按钮状态
                sender.selected = !sender.selected;
            }
            
            
        } failure:NULL];
        
    }
    else{
        //取消点赞
        NSDictionary *para = @{@"method":@"cancelPraiseNews",@"news_id":self.model.mId,@"user_id":userID};
        [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

            NSString *resCode = [[responseObject objectForKey:@"value"] objectForKey:@"resCode"];
            if ([resCode isEqualToString:@"0"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"取消点赞成功";
                [hud hide:YES afterDelay:0.5];
                
                //更改按钮状态
                sender.selected = !sender.selected;
            }
            
            
        } failure:NULL];
    }
    
    
}


//后面点击播放按钮
- (IBAction)playBtn:(UIButton *)sender {
    
    if (sender.selected == NO) {
        sender.selected = !sender.selected;
        [sender setBackgroundImage:[UIImage imageNamed:@"newsPause"] forState:UIControlStateNormal];
        [[BDTTSSynthesizer sharedInstance] pause];
        
    }else{
        sender.selected = !sender.selected;
        [sender setBackgroundImage:[UIImage imageNamed:@"newsLect"] forState:UIControlStateNormal];
        if (self.netWorkMgr.reachable) {
            [[BDTTSSynthesizer sharedInstance] resume];
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"您当前网络状态不良，请检查网络连接是否正常！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
            [alert addAction:OK];
            [self presentViewController:alert animated:YES completion:NULL];
        }
        
    }
}

//第一次点击播放按钮
- (IBAction)newsLect:(UIButton *)sender {
    
    //网络良好则播放
    if (self.netWorkMgr.reachable) {
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
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"您当前网络状态不良，请检查网络连接是否正常！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:OK];
        [self presentViewController:alert animated:YES completion:NULL];
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
