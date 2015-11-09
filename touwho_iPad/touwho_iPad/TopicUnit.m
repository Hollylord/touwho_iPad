//
//  TopicUnit.m
//  touwho_iPad
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "TopicUnit.h"
#import "SpecificTopicViewController.h"

@implementation TopicUnit
- (void)setModel:(ModelForTopic *)model{
    if (_model != model) {
        _model = model;
        
    }
    
    self.topicNameLabel.text = model.mShortTitle;
    self.groupNameLabel.text = model.mGroupName;
    self.timeLabel.text = model.mCreateTime;
    NSString *iconURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mLogo];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
}

#pragma mark - 话题点击控制器跳转
- (IBAction)turn2SpecifiTopicVC:(UITapGestureRecognizer *)sender {
    UIViewController *viewController = [self viewController];
    SpecificTopicViewController *spe = [[SpecificTopicViewController alloc] initWithNibName:@"SpecificTopicViewController" bundle:nil];
    spe.model = self.model;
    [viewController.navigationController pushViewController:spe animated:YES];
}

//获得当前view的控制器
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
