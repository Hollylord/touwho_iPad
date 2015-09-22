//
//  programView.h
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASProgressPopUpView.h"
#import "ModelForProgramView.h"

@protocol programViewDelegate <NSObject>
/**
 *  转到项目详细页面
 */
- (void)turn2DetailOfProgramsWithModel:(ModelForProgramView *)model;
@end


@interface programView : UIView <ASProgressPopUpViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet ASProgressPopUpView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak,nonatomic) id<programViewDelegate>delegate;
@property (strong,nonatomic) ModelForProgramView *model;

@end
