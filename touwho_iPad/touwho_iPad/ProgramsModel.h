//
//  ProgramsModel.h
//  touwho_iPad
//
//  Created by apple on 15/9/21.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
///这个模型废弃，统一到ModelForProgramView
@interface ProgramsModel : NSObject

@property (strong,nonatomic) UIImage *image;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *content;

@end
