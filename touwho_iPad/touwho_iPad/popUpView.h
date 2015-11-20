//
//  popUpView.h
//  ad
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 touwho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMap.h"

@interface popUpView : UIView

@property (strong,nonatomic) UILabel *activityName;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *place;

@property (strong,nonatomic)ModelMap *model;

@end
