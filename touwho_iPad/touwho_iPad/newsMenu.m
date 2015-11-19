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
    if ([self.delegate respondsToSelector:@selector(turn2newsDetail:)]) {
        [self.delegate turn2newsDetail:self.model];
    }
}

- (void)setModel:(ModelForNews *)model{
    if (_model != model) {
        _model = model;
    }
    NSURL *url = [NSURL URLWithString:model.smallImageURL];
    [self.newsIconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_background"]];
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    NSString *source = model.source;
    self.sourceLabel.text = [NSString stringWithFormat:@"来源：%@",source];
}
@end
