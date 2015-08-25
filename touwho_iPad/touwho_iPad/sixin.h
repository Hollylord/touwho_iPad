//
//  sixin.h
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sixin : UIView
@property (weak, nonatomic) IBOutlet UITableView *talks;
@property (weak, nonatomic) IBOutlet UITableView *replyView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property (weak, nonatomic) IBOutlet UIButton *toggleBtn;
@property (weak, nonatomic) IBOutlet UIButton *talkBtn;

- (IBAction)send:(UIButton *)sender;
- (IBAction)toggleKey:(UIButton *)sender;
- (IBAction)talk:(UIButton *)sender;

@end
