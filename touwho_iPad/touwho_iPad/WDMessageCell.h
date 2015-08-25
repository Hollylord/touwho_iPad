//
//  WDMessageCell.h
//  SuperPhoto
//
//  Created by 222ying on 15/7/15.
//  Copyright (c) 2015年 222ying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDMessageFrameModel;

@interface WDMessageCell : UITableViewCell
#warning 为了拥有这数据才弄出来的属性吗？？；
@property (nonatomic,strong) WDMessageFrameModel * frameMessage;  // frame 的模型
@property (nonatomic ,weak ) UILabel* time;  //显示的时间
@property (nonatomic ,weak)  UIButton * textView;  // 显示的正文
@property (nonatomic ,weak) UIImageView * icon;  // 用户头像


+(instancetype) messageCellWithTableView:(UITableView *) tableview;
@end
