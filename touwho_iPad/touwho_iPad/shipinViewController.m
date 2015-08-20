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
    
    _player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://pl.youku.com/playlist/m3u8?vid=321514956&type=flv&ts=1439366893&keyframe=0&ep=dCaXE0qLUMYJ5ifaiz8bMyW0ISQOXP0I9xqEhdtnBtQlTuC2&sid=643936689345312d9fec1&token=1689&ctype=12&ev=1&oip=3071127905"]];
    _player.view.frame = CGRectMake(0, 0, 375, 400);
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




@end
