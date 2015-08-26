//
//  meLeft.m
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "meLeft.h"

@implementation meLeft
- (void)awakeFromNib{
    UINib *nib = [UINib nibWithNibName:@"meLeftCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"meLeftCell"];
}
#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meLeftCell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    label.text = @"123";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        [self.delegate presentPublish];
    }
    else if (indexPath.row == 1)
    {
        [self.delegate presentPrograms];
    }
    else if (indexPath.row == 2)
    {
        [self.delegate presentApply];
        
    }
}


@end
