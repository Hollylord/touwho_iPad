//
//  chatTableViewCell.m
//  touwho_iPad
//
//  Created by apple on 15/9/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "chatTableViewCell.h"

#define widthOfContentView self.contentView.frame.size.width
#define heightOfContentView self.contentView.frame.size.height
@implementation chatTableViewCell

- (void)awakeFromNib {
    //拿到头像视图
    UIImageView *icon = (UIImageView *)[self viewWithTag:1];
    self.icon = icon;
    //拿到文本控件
    UIButton *information = (UIButton *)[self viewWithTag:2];
    self.information = information;

    //设置information按钮
    information.titleLabel.font = [UIFont systemFontOfSize:20];
    //自动换行
    self.information.titleLabel.numberOfLines = 0;
    self.information.contentEdgeInsets = UIEdgeInsetsMake(20, 10, 20, 10);
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  拿到信息
 *
 *  @param message <#message description#>
 */
- (void)setMessage:(AVIMMessage *)message{
    
    
    //通过消息，计算气泡高度
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
    
   CGSize msgSize = [message.content boundingRectWithSize:CGSizeMake(480, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
    //这条消息是本人发的
    if ([self.clientID isEqual:message.clientId]) {
        self.icon.frame = CGRectMake(widthOfContentView-60,10 ,50 , 50);
        
        [self.information setTitle:message.content forState:UIControlStateNormal];
        [self.information setBackgroundImage:[UIImage imageNamed:@"chat_send_nor"] forState:UIControlStateNormal];
        self.information.frame = CGRectMake(self.icon.frame.origin.x - msgSize.width-20, 10, msgSize.width, msgSize.height);
    }
    //对方发的
    else{
        self.icon.frame = CGRectMake(10,10 ,50 ,50);
        [self.information setTitle:message.content forState:UIControlStateNormal];
        [self.information setBackgroundImage:[UIImage imageNamed:@"chat_recive_press_pic"] forState:UIControlStateNormal];
        self.information.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+20, 10, msgSize.width, msgSize.height);
    }
}


@end
