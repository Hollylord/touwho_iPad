//
//  WDMessageFrameModel.h
//  SuperPhoto
//
//  Created by 222ying on 15/7/14.
//  Copyright (c) 2015年 222ying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WDMessageModel;




@interface WDMessageFrameModel : NSObject

@property (nonatomic , assign, readonly) CGRect iconF;
@property (nonatomic , assign, readonly) CGRect timeF;
@property (nonatomic , assign, readonly) CGRect textViewF;
//@property (nonatomic , assign, readonly) CGRect imageF;
@property (nonatomic , assign) CGFloat cellH;

@property (nonatomic , strong) WDMessageModel * message;

@end
