//
//  meLeft.m
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "meLeft.h"
#import "UIImage+UIimage_HeadIcon.h"
#import "RiskTestViewController.h"

@implementation meLeft
- (void)awakeFromNib{
    UINib *nib = [UINib nibWithNibName:@"meLeftCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"meLeftCell"];
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"headIcon"];
    if (filePath) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        UIImage *icon = [UIImage imageWithData:data];
        UIImage *newImage = [UIImage imageClipsWithHeadIcon:icon sideWidth:0];
        self.headImageView.image = newImage;
    }
    
    
}
#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 10;
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
            label.text = @"申请成为领投人";
            break;
        case 2:
            label.text = @"申请成为跟投人";
            break;
        case 3:
            label.text = @"发布项目";
            break;
        case 4:
            label.text = @"已投资的项目";
            break;
        case 5:
            label.text = @"已发布的项目";
            break;
        case 6:
            label.text = @"关注的项目";
            break;
        case 7:
            label.text = @"关注的机构";
            break;
        case 8:
            label.text = @"关注的投资人";
            break;
        case 9:
            label.text = @"风险评估测试";
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
    else if (indexPath.row == 5)
    {
        [self.delegate presentPublished];
        
    }
    else if (indexPath.row == 6)
    {
        [self.delegate presentFollowedProgram];
        
    }
    else if (indexPath.row == 7)
    {
        [self.delegate presentFollowedInstitution];
        
    }
    else if (indexPath.row == 8)
    {
        [self.delegate presentFollowedSponsor];
        
    }
    else if (indexPath.row == 9)
    {
        UIViewController *VC = [self viewController];
        RiskTestViewController *riskVC = [[RiskTestViewController alloc]initWithNibName:@"RiskTestViewController" bundle:nil];
        riskVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [VC presentViewController:riskVC animated:YES completion:NULL];
        
    }
}

#pragma mark - 按钮点击
- (IBAction)message:(UIButton *)sender {
    [self.delegate presentMessage];
    
}
//点击头像
- (IBAction)headClick:(UIButton *)sender {
    if (self.headClick) {
        self.headClick();
    }
}



#pragma mark -
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
