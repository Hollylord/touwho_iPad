//
//  AppDelegate.m
//  touwho_iPad
//
//  Created by apple on 15/8/13.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloudIM/AVOSCloudIM.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "APService.h"
#import "UMCheckUpdate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //设置leanCloud
    [AVOSCloud setApplicationId:@"9vyUjfA3OLiQeVD3P0TojM5Y" clientKey:@"QDSFGoFRxgDzohuf4JYRFvmD"];
    [AVIMClient setUserOptions:@{
                                 AVIMUserOptionUseUnread: @(YES)
                                 }];
    
    //设置talkingdata
    [TalkingData sessionStarted:@"D2DF7F18AEFA071E7F9A3FF9AC4B4409" withChannelId:@"ipad"];
    
    //友盟自动更新
    [UMCheckUpdate checkUpdateWithAppkey:@"5602081a67e58ec377001b17" channel:nil];
    
    
    //设置友盟
    [UMSocialData setAppKey:@"5602081a67e58ec377001b17"];
    
    //设置微信分享
    [UMSocialWechatHandler setWXAppId:@"wxaf4c01a34d15a51c" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    
    //设置qq分享SSO
    [UMSocialQQHandler setQQWithAppId:@"1104418305" appKey:@"foM35jqFXzDe1uOj" url:@"http://www.umeng.com/social"];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    
    //微博SSO
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 极光推送
    //可以添加自定义categories
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert)
                                           categories:nil];
    
    // Required
    [APService setupWithOption:launchOptions];
    
    //设置app的bage为0
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    
    
    return YES;
}


//分享的回调，此方法用于从其他app回到本app
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

//注册远程通知回调
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
    
}

//远程通知注册失败回调
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册失败，无法获取设备 ID, 具体错误: %@", error);
}

//处理远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSString *alertContentStr = [[NSString alloc]init];
    
    //在前台
    if (application.applicationState == UIApplicationStateActive) {

        
        if (userInfo) {
            NSDictionary *apsDic = [userInfo objectForKey:@"aps"];
            for (NSString *contentStr in [apsDic allKeys]) {
                if ([contentStr isEqualToString:@"alert"]) {
                    alertContentStr = [apsDic objectForKey:@"alert"];
                }
            }
            NSLog(@"%@",userInfo);
            
        }

    }
    //在后台
    else {
        
        if (userInfo) {
            
            NSString *jsonTypes = userInfo[@"jsonType"];
            NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"温馨提示"
                                      message:[NSString stringWithFormat:@"%@", alert]
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:@"确定",
                                      nil];
            alertView.tag = [jsonTypes integerValue];
            
            [alertView show];
        }
        
    }
    
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}



@end
