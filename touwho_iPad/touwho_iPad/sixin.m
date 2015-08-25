//
//  sixin.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "sixin.h"

@implementation sixin

- (void)awakeFromNib{
    UINib *nib = [UINib nibWithNibName:@"sixinCell" bundle:nil];
    [self.talks registerNib:nib forCellReuseIdentifier:@"sixinCell"];
    [self.replyView registerNib:nib forCellReuseIdentifier:@"sixinCell"];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sixinCell" forIndexPath:indexPath];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}




- (IBAction)send:(UIButton *)sender {
}

- (IBAction)toggleKey:(UIButton *)sender {
}

- (IBAction)talk:(UIButton *)sender {
}
@end
