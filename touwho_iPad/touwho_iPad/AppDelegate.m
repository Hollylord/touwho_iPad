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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置leanCloud
    [AVOSCloud setApplicationId:@"9vyUjfA3OLiQeVD3P0TojM5Y" clientKey:@"QDSFGoFRxgDzohuf4JYRFvmD"];
    
    //设置友盟分享
    [UMSocialData setAppKey:@"5602081a67e58ec377001b17"];
    
    //设置微信分享
    [UMSocialWechatHandler setWXAppId:@"wx43b8499d08842d8a" appSecret:@"80e470d7cc365cea2e677a87fb84e2bb" url:@"http://www.umeng.com/social"];
    
    //设置qq分享
    [UMSocialQQHandler setQQWithAppId:@"1104734143" appKey:@"otFu8s5Dv6u8sFBm" url:@"http://www.umeng.com/social"];
    
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



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
