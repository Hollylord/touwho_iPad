//
//  ModelForActivity.h
//  touwho_iPad
//
//  Created by apple on 15/10/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForActivity : NSObject

@property (assign,nonatomic) BOOL status;
@property (strong,nonatomic) UIImage *icon;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *introduction;
@end
