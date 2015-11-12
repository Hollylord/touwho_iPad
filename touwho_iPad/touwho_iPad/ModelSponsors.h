//
//  ModelSponsors.h
//  touwho_iPad
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelSponsors : NSObject
//名字
@property (copy,nonatomic) NSString *mName;
//头像url
@property (copy,nonatomic) NSString *mAvatar;
//投资金额
@property (copy,nonatomic) NSString *mInvestMoney;
///投资人的id
@property (copy,nonatomic) NSString *mID;
@end
