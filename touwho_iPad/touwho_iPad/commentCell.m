//
//  commentCell.m
//  touwho_iPad
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "commentCell.h"

@implementation commentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ModelForComment *)model {
    if (_model != model) {
        _model = model;
    }
    self.iconView.image = model.user.icon;
    self.userNameLabel.text = model.user.nickName;
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.time;
}
@end
