//
//  customAnnotationView.h
//  ad
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 touwho. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "popUpView.h"

@interface customAnnotationView : MAAnnotationView
@property (strong,nonatomic) popUpView *popView;
@property (copy,nonatomic) NSString *activtyName;
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *place;
@end
