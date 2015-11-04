//
//  ProgramsTableViewCell.m
//  touwho_iPad
//
//  Created by apple on 15/9/21.
//  Copyright © 2015年 touhu.com. All rights reserved.


#import "ProgramsTableViewCell.h"

@implementation ProgramsTableViewCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
}

- (void)setModel:(ModelMyProgram *)model{
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = model.mTitle;
    self.contentTextView.text = model.mDestrible;
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mSmallImageUrl];
    NSURL *url = [NSURL URLWithString:imageURL];
    [self.IMGView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
}


@end
