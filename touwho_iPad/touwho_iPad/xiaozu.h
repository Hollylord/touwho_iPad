//
//  xiaozu.h
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xiaozu : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *splitLine1;
@property (weak, nonatomic) IBOutlet UIImageView *splitLine2;

///装热门小组model的数组
@property (strong,nonatomic) NSMutableArray *hotModels;
///装我加入的小组model的数组
@property (strong,nonatomic) NSMutableArray *myModels;
@end
