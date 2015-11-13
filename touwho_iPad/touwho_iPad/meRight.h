//
//  meRight.h
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "meLeft.h"
#import "privateMessage.h"

@interface meRight : UIView <meLeftDelegate,UITableViewDataSource,UITableViewDelegate>

///私信页面
@property (strong,nonatomic) privateMessage *messageView;
///存放对话的数组
@property (strong,nonatomic) NSMutableArray *conversations;
@end
