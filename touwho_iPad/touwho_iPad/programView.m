//
//  programView.m
//  touwho_iPad
//
//  Created by apple on 15/8/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "programView.h"
#import "program2ViewController.h"

@implementation programView

- (IBAction)tapProgram:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(turn2DetailOfPrograms)])
    {
        [self.delegate turn2DetailOfPrograms];
    }
}

- (void)awakeFromNib{
    //配置progressView 进度条
    [self.progressView showPopUpViewAnimated:YES];
    self.progressView.progress = 0.0;
    self.progressView.popUpViewCornerRadius = 8.0;
   
    self.progressView.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:20];
    self.progressView.dataSource = self;
    self.progressView.popUpViewColor = [UIColor grayColor];
    
    [self progress];
    
    
    
}

- (BOOL)progressViewShouldPreCalculatePopUpViewSize:(ASProgressPopUpView *)progressView;
{
    return NO;
}

- (NSString *)progressView:(ASProgressPopUpView *)progressView stringForProgress:(float)progress{
    
    return nil;
    
}

#pragma mark - 进度条
- (void)progress
{
    
    float progress = self.progressView.progress;
    //设置进度条的进度
    if (progress < 0.5 ) {
        
        progress += 0.005;
        
        [self.progressView setProgress:progress animated:YES];
        
        //调进度条的速度
        [NSTimer scheduledTimerWithTimeInterval:0.03
                                         target:self
                                       selector:@selector(progress)
                                       userInfo:nil
                                        repeats:NO];
    }
}
@end
