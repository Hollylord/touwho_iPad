//
//  shipinView.m
//  touwho_iPad
//
//  Created by apple on 15/8/20.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "shipinView.h"

@implementation shipinView
- (IBAction)play:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playNotification" object:self];
}


@end
