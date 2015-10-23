//
//  ModelForNews.h
//  touwho_iPad
//
//  Created by apple on 15/10/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForNews : NSObject
@property (strong,nonatomic) UIImage *iconImage;
@property (strong,nonatomic) UIImage *image;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *source;
@property (copy,nonatomic) NSString *content;

@end
