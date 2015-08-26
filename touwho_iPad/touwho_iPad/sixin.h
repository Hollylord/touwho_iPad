//
//  sixin.h
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Headers/BDRecognizerViewController.h"
#import "BDVRSConfig.h"
#import "UIView+Extension.h"

#import "WDMessageCell.h"
#import "WDMessageFrameModel.h"
#import "WDMessageModel.h"
#import "WDMessageTool.h"

@interface sixin : UIView <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,BDRecognizerViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomOfInput;

@property (weak, nonatomic) IBOutlet UITableView *talks;
@property (weak, nonatomic) IBOutlet UITableView *replyView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property (weak, nonatomic) IBOutlet UIButton *toggleBtn;
@property (weak, nonatomic) IBOutlet UIButton *talkBtn;
@property (nonatomic, retain) BDRecognizerViewController *recognizerViewController;
@property (weak, nonatomic) IBOutlet UIView *contentBView;
@property (nonatomic , strong) NSDictionary  *autoReplay;// 这个弄好了以后就是一个懒加载；
@property (nonatomic ,strong) NSMutableArray * messages;

- (IBAction)send:(UIButton *)sender;
- (IBAction)toggleKey:(UIButton *)sender;
- (IBAction)talk:(UIButton *)sender;

@end
