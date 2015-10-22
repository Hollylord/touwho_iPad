//
//  SettingViewController.m
//  touwho_iPad
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"

@interface SettingViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController
{
    UIView *whiteView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ios9以后 tableView必须注册cell，只要注册了 以后就在cellForRowAt这个方法中直接dequeue就可以了
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    
    //给tableView添加白view遮挡下面不要的
    whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    //给whiteView约束
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:whiteView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:whiteView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:whiteView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTop multiplier:1 constant:2*50];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:whiteView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [whiteView.superview addConstraints:@[leading,trailing,top,bottom]];
    whiteView.translatesAutoresizingMaskIntoConstraints = NO;


}
//关闭页面
- (IBAction)closeViewController:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//退出当前账号
- (IBAction)quitAccount:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出" message:@"确定退出当前账号吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
        
        [self dismissViewControllerAnimated:YES completion:^{
            //发送点击了项目按钮的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"programNotification" object:nil];
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:OK];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"清空缓存";
    }
    else if (indexPath.row == 1){
        cell.textLabel.text = @"关于";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }
    else if (indexPath.row == 1)
    {
        AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];

        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
