//
//  chatTableViewCell.h
//  touwho_iPad
//
//  Created by apple on 15/9/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloudIM/AVIMMessage.h>

@interface chatTableViewCell : UITableViewCell


/**
 *  用于接收消息
 */
@property (copy,nonatomic) AVIMMessage *message;
/**
 *  本机clientID
 */
@property (copy,nonatomic) NSString *clientID;
@property (strong,nonatomic) UIImageView *icon;
@property (strong,nonatomic) UIButton *information;
@end
