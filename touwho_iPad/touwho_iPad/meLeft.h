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
 *  编辑个人信息
 */
- (void)presentProfile;

@end



@interface meLeft : UIView <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak,nonatomic) id <meLeftDelegate>delegate;
@end
