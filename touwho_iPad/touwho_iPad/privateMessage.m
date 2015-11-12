//
//  privateMessage.m
//  touwho_iPad
//
//  Created by apple on 15/9/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "privateMessage.h"
#import "sixinViewController.h"

@implementation privateMessage
- (void)awakeFromNib{
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatTableViewCell"];
    
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //创建长连接和会话: 将自己的id和朋友的id赋值
    [self openSessionByClientId:USER_ID navigationToIMWithTargetClientIDs:@[@"38"]];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)openSessionByClientId:(NSString*)clientId navigationToIMWithTargetClientIDs:(NSArray *)clientIDs {
    [[LeanMessageManager manager] openSessionWithClientID:clientId completion:^(BOOL succeeded, NSError *error) {
        if(!error){
            ConversationType type;
            if(clientIDs.count>1){
                type=ConversationTypeGroup;
            }else{
                type=ConversationTypeOneToOne;
            }
            [[LeanMessageManager manager] createConversationsWithClientIDs:clientIDs conversationType:type completion:^(AVIMConversation *conversation, NSError *error) {
                if(error){
                    NSLog(@"error=%@",error);
                }else{
                    sixinViewController *vc = [[sixinViewController alloc] initWithConversation:conversation];
                    vc.friendId = [clientIDs firstObject];
                    vc.modalPresentationStyle = UIModalPresentationFormSheet;
                    //利用响应者链条获得这个view的控制器
                    UIViewController* controller = [self viewController];
                    
                    //弹出回复控制器 界面
                    [controller presentViewController:vc animated:YES completion:NULL];
                }
            }];
        }else{
            NSLog(@"error=%@",error);
        }
    }];
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
