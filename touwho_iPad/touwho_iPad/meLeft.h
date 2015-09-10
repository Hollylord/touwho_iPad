//
//  meLeft.h
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol meLeftDelegate
/**
 *  发布项目
 */
- (void)presentPublish;
/**
 *  已投资的项目
 */
- (void)presentPrograms;
/**
 *  申请领投人资格页面
 */
- (void)presentApply;
/**
 *  申请投资人资格
 */
- (void)presentSponsor;
/**
 *  编辑个人信息
 */
- (void)presentProfile;
/**
 *  跳转消息界面
 */
- (void)presentMessage;

@end



@interface meLeft : UIView <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic) id <meLeftDelegate>delegate;
/**
 *  查看消息
 */
- (IBAction)message:(UIButton *)sender;
- (IBAction)headClick:(UIButton *)sender;


/**
 *  通知控制器头像被点击
 */
@property (copy,nonatomic) void (^headIconClick)();


@end
