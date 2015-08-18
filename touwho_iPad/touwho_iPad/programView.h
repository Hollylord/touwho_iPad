//
//  programView.h
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASProgressPopUpView.h"

@protocol programViewDelegate <NSObject>
- (void)tap;
@end


@interface programView : UIView <ASProgressPopUpViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet ASProgressPopUpView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *currentAmount;
@property (weak, nonatomic) IBOutlet UILabel *percent;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak,nonatomic) id<programViewDelegate>delegate;

@end
