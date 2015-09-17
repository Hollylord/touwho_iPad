//
//  HeadIconViewController.h
//  touwho_iPad
//
//  Created by apple on 15/9/17.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadIconViewController : UIViewController
@property (copy, nonatomic) void (^passImage)(UIImage *);

@end
