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
    NSString *iconURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mLogo];
    
    [self.writerIcon sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:[UIImage imageNamed:@"logo_background"]];
    self.timeLabel.text = model.mCreateTime;
    self.titleLabel.text = model.mTitle;
    self.contentLabel.text = model.mDestrible;
}
@end
