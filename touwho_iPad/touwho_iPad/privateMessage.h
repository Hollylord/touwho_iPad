//
//  privateMessage.h
//  touwho_iPad
//
//  Created by apple on 15/9/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelChating.h"

@interface privateMessage : UIView <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

///存放朋友id
@property (strong,nonatomic) NSMutableArray *friendsId;

///存放所有的对话model
@property (strong,nonatomic) NSMutableArray *conversations;
@end
