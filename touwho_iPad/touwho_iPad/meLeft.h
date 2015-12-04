//
//  meLeft.h
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForUser.h"

@class meLeft;
@protocol meLeftDelegate
/**
 *  跳转消息界面
 */
- (void)presentMessage;

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
- (void)presentProfileWithSender:(meLeft *)sender;
/**
 *  已发起的项目
 */
- (void)presentPublished;
///**
// *  关注的项目
// */
//- (void)presentFollowedProgram;
///**
// *  关注的机构
// */
//- (void)presentFollowedInstitution;
///**
// *  关注的投资人
// */
//- (void)presentFollowedSponsor;
@end



@interface meLeft : UIView <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic) id <meLeftDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *symbolView;

@property (strong,nonatomic) ModelForUser *model;



/**
 *  查看消息
 */
- (IBAction)message:(UIButton *)sender;
- (IBAction)headClick:(UIButton *)sender;
/**
 *  控制器present出头像设置控制器
 */
@property (copy,nonatomic) void (^headClick)();

@end


