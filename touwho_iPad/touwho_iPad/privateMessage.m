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
    [self.tableView registerNib:[UINib nibWithNibName:@"commentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
    
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //利用响应者链条获得这个view的控制器
    UIViewController* controller = [self viewController];
    sixinViewController *sixinVC = [[sixinViewController alloc] initWithNibName:@"sixinViewController" bundle:nil];
    sixinVC.modalPresentationStyle = UIModalPresentationFormSheet;
    //弹出回复控制器 界面
    [controller presentViewController:sixinVC animated:YES completion:NULL];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
