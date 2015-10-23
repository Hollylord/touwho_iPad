//
//  splitViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "splitViewController.h"
#import "loginViewController.h"
#import "profileViewController.h"


@interface splitViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,weak) UIButton *advertButton;
@property (nonatomic,strong) UIImageView * image;


@end

@implementation splitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.minimumPrimaryColumnWidth = 100;
    self.maximumPrimaryColumnWidth = 100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:nil object:nil];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"version"] == nil) {
//        [self showADScrollView];
    }
    
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark - 收到通知
- (void)receiveNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"programNotification"]) {
        self.block();
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"shouyeNavigation"] sender:nil];
    }
    else if ([notification.name isEqualToString:@"discoveryNotification"]){
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"discoveryNavigation"] sender:nil];
    }
    else if ([notification.name isEqualToString:@"loginNotification"]){
        
        NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        //验证用户存在则直接跳转个人中心
        if (user) {
            profileViewController *viewcontroller = [[profileViewController alloc] initWithNibName:@"profileViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
            [self showDetailViewController:navigationController sender:nil];
            
        }
        else {
            //跳转登录VC
            loginViewController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            login.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:login animated:YES completion:NULL];
        }
        
    }
    else if ([notification.name isEqualToString:@"newsNotification"]){
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"newsNavigation"] sender:nil];
    }
}

- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return (UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight);
}

//添加广告页
-(void)showADScrollView{
    CGRect imageFrame = CGRectMake(0, 0, 1024, 768);
    NSLog(@"%@",NSStringFromCGRect(imageFrame));
    UIImageView * image = [[UIImageView alloc] initWithFrame:imageFrame];
    image.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:image];
    self.image = image;
    
    
    
    
    
    //创建1个scrollview
    self.scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(imageFrame.origin.x, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height)];
    self.scrollView.contentSize = CGSizeMake(imageFrame.size.width * 5, imageFrame.size.height);
    self.scrollView.pagingEnabled = YES;   //这个要开启；
    self.scrollView.delegate = self;
    //    self.scrollView.showsHorizontalScrollIndicator = NO;
    //    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    // self.scrollView.bounces = NO;
    
    [self.view addSubview:self.scrollView];
    
    
    //创建5个imageview
    int i;
    for (i = 0; i < 5; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(imageFrame.origin.x + i * imageFrame.size.width, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height);
        NSString *imageName = [NSString stringWithFormat:@"advert%d",i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"advertButton"];
    //            [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    button.frame = CGRectMake((imageFrame.size.width - 200)/2 + imageFrame.size.width *4, imageFrame.size.height - 150, 200, 100);
    self.advertButton = button;
    [button addTarget:self action:@selector(turnToHomeViewController) forControlEvents:UIControlEventTouchUpInside];
    //一定要把按钮添加到scrollview上面
    [self.scrollView addSubview:self.advertButton];
    
    
    
    
    
    
    //创建pagecontrol
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake(100, imageFrame.size.height - 50, 100, 30);
    CGPoint center = self.pageControl.center;
    center.x = self.view.center.x;
    self.pageControl.center= center;
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 5;
    self.pageControl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pageControl];
    
}


#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{  // 滑动完毕后的scrollView可以拿到里面的位移；
    
    
    
    
    CGPoint contentOffset = scrollView.contentOffset;
    
    
    int i = contentOffset.x / self.view.frame.size.width;
    
    CGFloat currentWidth = [UIScreen mainScreen].applicationFrame.size.width;
    
    // NSLog(@"---%f",contentOffset.x);
    
    if (contentOffset.x <= currentWidth) {
        self.image.alpha = 1.0f;
    }
    
    if (contentOffset.x > currentWidth) {
        self.image.alpha = 0.5f;
    }
    
    
    
    
    
    if (contentOffset.x > currentWidth*4+50) {
        [self.scrollView removeFromSuperview];
        [self.pageControl removeFromSuperview];
        
        
        
        [UIView animateWithDuration:0.25f animations:^{
            self.image.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            [self.image removeFromSuperview];
        }];
        
        
    }
    
    
    self.pageControl.currentPage = i;
}

#pragma mark - 点击按钮
- (void)turnToHomeViewController{
    [self.scrollView removeFromSuperview];
    
    [self.pageControl removeFromSuperview];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.image.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [self.image removeFromSuperview];
    }];
}



@end
