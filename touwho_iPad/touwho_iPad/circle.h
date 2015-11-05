//
//  circle.h
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface circle : UIView
@property (weak, nonatomic) IBOutlet UISegmentedControl *segement;
///装3个子视图
@property (strong,nonatomic) NSMutableArray *views;
@end
