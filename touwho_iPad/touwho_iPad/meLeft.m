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
    
    
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meLeftCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    switch (indexPath.row) {
        case 0:
            label.text = @"编辑个人信息";
            break;
        case 1:
            label.text = @"申请领投资格";
            break;
        case 2:
            label.text = @"申请投资人资格";
            break;
        case 3:
            label.text = @"发布项目";
            break;
        case 4:
            label.text = @"已投资的项目";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        [self.delegate presentProfile];
    }
    else if (indexPath.row == 1)
    {
        [self.delegate presentApply];
        
    }
    else if (indexPath.row == 2)
    {
        [self.delegate presentSponsor];
        
    }
    else if (indexPath.row == 3)
    {
        [self.delegate presentPublish];
        
    }
    else if (indexPath.row == 4)
    {
        [self.delegate presentPrograms];

    }
}


@end
