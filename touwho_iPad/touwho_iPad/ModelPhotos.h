//
//  ModelPhotos.h
//  touwho_iPad
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelPhotos : NSObject

///图片的id
@property (copy,nonatomic) NSString *mID;
///图片的url
@property (copy,nonatomic) NSString *mImageUrl;
///图片的顺序
@property (copy,nonatomic) NSString *mOrder;
///图片跳转的url
@property (copy,nonatomic) NSString *mTargetUrl;

@end
