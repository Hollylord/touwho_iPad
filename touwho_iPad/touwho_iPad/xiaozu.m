//
//  xiaozu.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "xiaozu.h"

@implementation xiaozu
- (void)awakeFromNib{
    UINib *nib = [UINib nibWithNibName:@"xiaozuCell" bundle:nil];
    [self.tuijian registerNib:nib forCellReuseIdentifier:@"xiaozuCell"];
    [self.enrolled registerNib:nib forCellReuseIdentifier:@"xiaozuCell"];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"xiaozuCell" forIndexPath:indexPath];
        return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
