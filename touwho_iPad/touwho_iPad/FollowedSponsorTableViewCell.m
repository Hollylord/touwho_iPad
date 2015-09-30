//
//  FollowedSponsorTableViewCell.m
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "FollowedSponsorTableViewCell.h"

@implementation FollowedSponsorTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(SponsorModel *)model{
    if (_model != model) {
        _model = model;
    }
    self.headIconIMG.image = model.image;
    self.nameLabel.text = model.name;
}
@end
