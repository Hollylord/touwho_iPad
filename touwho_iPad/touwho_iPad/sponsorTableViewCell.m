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
- (void)setModel:(ModelForSponsor *)model{
    if (_model != model) {
        _model = model;
        
        self.headIconIMG.image = model.image;
        self.label1.text = model.name;
        self.label2.text = model.amount;
        self.label3.text = model.time;
    }

}
@end
