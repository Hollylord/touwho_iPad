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


- (void)setModel:(ProgramsModel *)model{
    self.model = model;
    self.IMGView.image = model.image;
}

@end
