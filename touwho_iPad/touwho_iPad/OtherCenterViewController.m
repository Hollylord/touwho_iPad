//
//  OtherCenterViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/10.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "OtherCenterViewController.h"

@interface OtherCenterViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSArray *titles;
@end

@implementation OtherCenterViewController
- (NSArray *)titles{
    if (!_titles) {
        _titles = [NSArray array];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"关注的项目",@"关注的机构"];
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"OtherCenterCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherCenterCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherCenterCell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"logo"];
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
