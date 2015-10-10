//
//  newsMenu.h
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForNews.h"

@protocol newsMenuDelegate <NSObject>
//news1跳转到新闻详情页面(可以传递参数)
- (void)turn2newsDetail;

@end


@interface newsMenu : UIView
@property (weak, nonatomic) IBOutlet UIImageView *newsIconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;

@property (strong,nonatomic) ModelForNews *model;

- (IBAction)tapProgram:(UITapGestureRecognizer *)sender;
@property (weak,nonatomic) id<newsMenuDelegate>delegate;

@end
