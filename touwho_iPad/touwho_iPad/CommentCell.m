//
//  commentCell.m
//  touwho_iPad
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ModelForComment *)model {
    if (_model != model) {
        _model = model;
    }
    NSString *iconURL;
    if ([BTNetWorking isTheStringContainedHttpWithString:model.mAvatar]) {
        iconURL = model.mAvatar;
    }
    else{
        iconURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mAvatar];
    }
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconURL] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    self.userNameLabel.text = model.mName;
    self.contentLabel.text = model.mTalkContent;
    self.timeLabel.text = model.mCreateTime;
    //设置点赞按钮的状态
    if ([model.mIsPraise isEqualToString:@"0"]) {
        self.thumb.selected = NO;
    }
    else{
        self.thumb.selected = YES;
    }
    
}

#pragma mark - 点赞
- (IBAction)thumbUp:(UIButton *)sender {
    if (![BTNetWorking isUserAlreadyLoginWithAlertView:self]) {
        return ;
    }
   
    //点赞
    if (!sender.selected) {
        NSDictionary *para = @{@"method":@"praiseTalkComment",@"user_id":USER_ID,@"talk_comment_id":self.model.mTalkCommentID};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            sender.selected = !sender.selected;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }
    //取消点赞
    else{
        NSDictionary *para = @{@"method":@"cancelPriaseTalkComment",@"user_id":USER_ID,@"talk_comment_id":self.model.mTalkCommentID};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            sender.selected = !sender.selected;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
        }];
    }
}
@end
