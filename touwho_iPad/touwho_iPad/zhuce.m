//
//  zhuce.m
//  touwho_iPad
//
//  Created by apple on 15/9/6.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "zhuce.h"

@implementation zhuce



- (IBAction)return:(UIButton *)sender {
    if (self.block){
        self.block();
    }
}
@end
