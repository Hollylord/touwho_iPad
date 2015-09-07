//
//  message.h
//  touwho_iPad
//
//  Created by apple on 15/9/7.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface message : UIView
/**
 *  滑块
 */
@property (weak, nonatomic) IBOutlet UIImageView *sliderBar;

- (IBAction)notice:(UIButton *)sender;
- (IBAction)privateMessage:(UIButton *)sender;

@end
