//
//  JiGouMenuView.h
//  touwho_iPad
//
//  Created by apple on 15/9/15.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiGouMenuView : UIView

///用来装model的数组
@property (strong,nonatomic) NSMutableArray *models;

- (IBAction)turn2JiGouVC:(UITapGestureRecognizer *)sender;
- (IBAction)follow:(UIButton *)sender;

@end
