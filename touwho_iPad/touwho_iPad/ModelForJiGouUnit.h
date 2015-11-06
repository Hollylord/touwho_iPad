//
//  ModelForJiGouUnit.h
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForJiGouUnit : NSObject

///机构缩写
@property (copy,nonatomic) NSString *mShortName;
///机构名称
@property (copy,nonatomic) NSString *mName;
///机构logo
@property (copy,nonatomic) NSString *mLogo;
///机构创建时间
@property (copy,nonatomic) NSString *mCreateTime;
///机构简介
@property (copy,nonatomic) NSString *mDestrible;
///机构顺序
@property (copy,nonatomic) NSString *mOrder;
@end
