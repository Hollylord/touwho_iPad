//
//  leftViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "leftViewController.h"
#import "UIImage+UIimage_HeadIcon.h"
#import "splitViewController.h"
#import "AboutViewController.h"
#import "SettingViewController.h"
#import "profileViewController.h"
#import "loginViewController.h"


@interface leftViewController () <UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *program;
@property (weak, nonatomic) IBOutlet UIButton *news;
@property (weak, nonatomic) IBOutlet UIButton *discovery;
@property (weak, nonatomic) IBOutlet UIButton *me;

- (IBAction)menuClick:(UIButton *)sender;




@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置splitVC的block
    splitViewController *splitVC = (splitViewController *)[self splitViewController];
    splitVC.block = ^(){
        self.program.selected = YES;
        self.news.selected = NO;
        self.discovery.selected = NO;
        self.me.selected = NO;
    };
    
    //设置按钮状态
    self.program.selected = YES;
    self.news.selected = NO;
    self.discovery.selected = NO;
    self.me.selected = NO;
    
    //监听通知：获取最新头像
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headImage) name:@"setHeadImageView" object:nil];
    //监听通知：删除头像
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteHeadIcon) name:@"changeHeadIcon" object:nil];
    
    

    
    //取出本地头像
    if (USER_ID) {
        [self headImage];
    }
    else{
        UIImage *zhanweitu = [UIImage imageNamed:@"zhanweitu"];
        UIImage *temp = [UIImage imageClipsWithHeadIcon:zhanweitu sideWidth:0];
        self.headImageView.image = temp;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


#pragma mark - 按钮点击
- (IBAction)menuClick:(UIButton *)sender {
    //项目
    if (sender.tag == 0 ) {
        if (sender.selected) {
            return ;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"programNotification" object:nil];
        self.program.selected = YES;
        self.news.selected = NO;
        self.discovery.selected = NO;
        self.me.selected = NO;
        
    }
    //新闻
    else if (sender.tag == 1 )
    {
        if (sender.selected) {
            return ;
        }
        
        self.program.selected = NO;
        self.news.selected = YES;
        self.discovery.selected = NO;
        self.me.selected = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newsNotification" object:nil];
        
    }
    //发现
    else if (sender.tag == 2 )
    {
        if (sender.selected) {
            return ;
        }
        
        self.program.selected = NO;
        self.news.selected = NO;
        self.discovery.selected = YES;
        self.me.selected = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"discoveryNotification" object:nil];
    }
    //我
    else {
        //保存其他三个按钮的状态
        NSArray *statesArr = @[@(self.program.selected),@(self.news.selected),@(self.discovery.selected)];
        
        if (sender.selected) {
            return ;
        }
        
        NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        //验证用户存在则直接跳转个人中心
        if (user) {
            
            
            profileViewController *viewcontroller = [[profileViewController alloc] initWithNibName:@"profileViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
            [self.splitViewController showDetailViewController:navigationController sender:nil];
            
        }
        else {
            //跳转登录VC
            loginViewController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            login.quitBlock = ^(){
                self.me.selected = NO;
                self.program.selected = [[statesArr objectAtIndex:0] boolValue];
                self.news.selected = [[statesArr objectAtIndex:1] boolValue];
                self.discovery.selected = [[statesArr lastObject] boolValue];
            };
            login.modalPresentationStyle = UIModalPresentationFormSheet;
            [self.splitViewController presentViewController:login animated:YES completion:NULL];
        }
        
        //发送被点击的通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotification" object:nil];
        self.program.selected = NO;
        self.news.selected = NO;
        self.discovery.selected = NO;
        self.me.selected = YES;
    }
    
}
#pragma mark - 收到通知
- (void)deleteHeadIcon{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"headIcon"];
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:filePath error:nil];
    
    UIImage *head = [UIImage imageNamed:@"zhanweitu"];
    self.headImageView.image = [UIImage imageClipsWithHeadIcon:head sideWidth:0];
}

//接到通知换头像
- (void)headImage{
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSString *url = [user objectForKey:@"iconURL"];
    
    //如果url包含http
    if ([BTNetWorking isTheStringContainedHttpWithString:url]) {
        SDWebImageManager *mgr = [SDWebImageManager sharedManager];
        [mgr downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            UIImage *newImage = [UIImage imageClipsWithHeadIcon:image sideWidth:0];
            self.headImageView.image = newImage;
            
        }];
    }
    else{
        NSString *iconURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,url];
        SDWebImageManager *mgr = [SDWebImageManager sharedManager];
        [mgr downloadImageWithURL:[NSURL URLWithString:iconURL] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            UIImage *newImage = [UIImage imageClipsWithHeadIcon:image sideWidth:0];
            self.headImageView.image = newImage;
            
        }];
    }
   
    
    
}

//点击logo
- (IBAction)tapLogo:(UITapGestureRecognizer *)sender {
    
    SettingViewController *setVC = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:setVC];
    navi.modalPresentationStyle = UIModalPresentationFormSheet;
    AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [navi pushViewController:aboutVC animated:NO];
    
    [self.splitViewController presentViewController:navi animated:YES completion:NULL];
}

#pragma mark -
//通过文件名查找Cache目录下的image
- (UIImage *)searchImageFromCacheWithFileName:(NSString *)name{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

- (BOOL)shouldAutorotate{
    
    return NO;
    
}
//支持哪些方向，如果info禁止了，那些方向也不支持
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}
@end
