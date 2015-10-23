//
//  newsMenu.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "newsMenu.h"

@implementation newsMenu

- (IBAction)tapProgram:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(turn2newsDetail)]) {
        [self.delegate turn2newsDetail];
    }
}

- (void)setModel:(ModelForNews *)model{
    if (_model != model) {
        _model = model;
    }
    self.newsIconView.image = model.iconImage;
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    NSString *source = model.source;
    self.sourceLabel.text = [NSString stringWithFormat:@"来源：%@",source];
}
@end
