//
//  zhuce.h
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhuce : UIView
/**
 *  跟loginViewcontroller之间的通信
 */
@property (copy,nonatomic) dispatch_block_t block;
- (IBAction)return:(UIButton *)sender;

@end
