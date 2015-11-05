//
//  topics.h
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForTopic.h"

@interface topics : UIView

@property (weak, nonatomic) IBOutlet UIImageView *splitLine1;
@property (weak, nonatomic) IBOutlet UIImageView *splitLine2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

///装热门话题model的数组
@property (strong,nonatomic) NSMutableArray *hotModels;
///装我加入的话题model的数组
@property (strong,nonatomic) NSMutableArray *myModels;






@end
