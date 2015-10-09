//
//  TopicCell.m
//  touwho_iPad
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ModelForTopic *)model{
    if (_model != model) {
        _model = model;
    }
    self.writerIcon.image = model.publisher.icon;
    self.writerNickName.text = model.publisher.nickName;
    self.timeLabel.text = model.time;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
}
@end
