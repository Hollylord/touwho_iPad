//
//  LingTouViewController.h
//  touwho_iPad
//
//  Created by apple on 15/9/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LingTouViewController : UIViewController
///是否为领头
@property (assign,nonatomic) BOOL isLingtou;

///项目id
@property (copy,nonatomic) NSString *projectID;
@end
