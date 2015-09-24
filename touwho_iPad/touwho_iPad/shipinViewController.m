//
//  shipinViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/20.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "shipinViewController.h"
#import  <MediaPlayer/MediaPlayer.h>

@interface shipinViewController ()
{
    MPMoviePlayerController *_player;
}
@end

@implementation shipinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share1"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
    
    _player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://pl.youku.com/playlist/m3u8?vid=321514956&type=flv&ts=1439366893&keyframe=0&ep=dCaXE0qLUMYJ5ifaiz8bMyW0ISQOXP0I9xqEhdtnBtQlTuC2&sid=643936689345312d9fec1&token=1689&ctype=12&ev=1&oip=3071127905"]];
    _player.view.frame = CGRectMake(0, 64, 923, 768 - 64);
    _player.scalingMode = MPMovieScalingModeAspectFit;
    //    [_play setFullscreen:YES animated:YES];
    
    [self.view addSubview:_player.view];
    [_player play];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
