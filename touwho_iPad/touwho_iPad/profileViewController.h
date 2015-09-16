//
//  profileViewController.h
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileViewController : UIViewController
/**
 *  显示拍照后的照片
 */
@property (copy,nonatomic) void (^presentBusinessCard)(UIImage *);
@end
