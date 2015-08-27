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
@end
