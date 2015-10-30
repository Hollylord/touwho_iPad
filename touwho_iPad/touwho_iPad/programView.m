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
{
    //设置的progress
    CGFloat percent;
}

//点击某个项目
- (IBAction)tapProgram:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(turn2DetailOfProgramsWithModel:)])
    {
        [self.delegate turn2DetailOfProgramsWithModel:self.model];
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
    
    
    
    
    
}


#pragma mark - 进度条

- (BOOL)progressViewShouldPreCalculatePopUpViewSize:(ASProgressPopUpView *)progressView
{
    return NO;
}

- (NSString *)progressView:(ASProgressPopUpView *)progressView stringForProgress:(float)progress{
    
    return nil;
    
}

- (void)setProgressWithProgress{
    CGFloat progress = self.progressView.progress;
    //设置进度条的进度
    if (progress < percent ) {
        
        progress += 0.005;
        
        [self.progressView setProgress:progress animated:YES];
        
        //调进度条的速度
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                         target:self
                                       selector:@selector(setProgressWithProgress)
                                       userInfo:nil
                                        repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }

}
#pragma mark - 获取model
- (void)setModel:(ModelForProgramView *)model{
    if (_model != model) {
        _model = model;
        
        self.title.text = model.mTitle;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,model.mFullImageUrl]];
        [self.backgroundImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
        percent = [model.mCurMoney floatValue]/[model.mGoalMoney floatValue];
        [self setProgressWithProgress];
        self.label1.text = model.mCurMoney;
        self.label2.text = [NSString stringWithFormat:@"%.0f%%",percent*100];
        self.label3.text = model.mGoalMoney;
        
    }
    
}

@end
