//
//  modelForOtherVC.h
//  touwho_iPad
//
//  Created by apple on 15/10/3.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface modelForOtherVC : NSObject
//头像
@property (strong,nonatomic) UIImage *image;
//昵称
@property (copy,nonatomic) NSString *nickName;
//投资理念
@property (copy,nonatomic) NSString *concept;

//包含一个model是不对的，要包含数组，数组里面放着的是所有的model
@end
