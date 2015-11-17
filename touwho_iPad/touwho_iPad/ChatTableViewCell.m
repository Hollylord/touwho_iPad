//
//  ChatTableViewCell.m
//  touwho_iPad
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ModelChating *)model{
    if (_model != model) {
        _model = model;
    }
    
    NSString *userID = [model.members firstObject];
    if (!userID) {
        return ;
    }
    [BTNetWorkingAPI pullUserInfoFromServerWith:userID andBlock:^(ModelForUser *user) {
        NSString *iconURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,user.mAvatar];
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
        self.nickName.text = user.mNickName;
        
    }];
}
@end
