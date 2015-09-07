//
//  forgetPassword.m
//  touwho_iPad
//
//  Created by apple on 15/9/7.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "forgetPassword.h"

@implementation forgetPassword



- (IBAction)return:(UIButton *)sender {
    if (self.block){
        self.block();
    }
}
@end
