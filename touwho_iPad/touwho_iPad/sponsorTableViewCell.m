//
//  sponsorTableViewCell.m
//  touwho_iPad
//
//  Created by apple on 15/9/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "sponsorTableViewCell.h"

@implementation sponsorTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ModelSponsors *)model{
    if (_model != model) {
        _model = model;
        
        [self.headIconIMG sd_setImageWithURL:[NSURL URLWithString:model.mAvatar] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
        self.label1.text = model.mName;
        self.label3.text = model.mInvestMoney;
    }

}
@end
