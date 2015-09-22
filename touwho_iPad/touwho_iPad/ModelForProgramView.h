//
//  ModelForProgramView.h
//  touwho_iPad
//
//  Created by apple on 15/9/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForProgramView : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *currentAmount;
@property (assign, nonatomic) CGFloat percent;
@property (copy, nonatomic) NSString *totalAmount;
@property (strong,nonatomic) UIImage *backIMG;
@end
