//
//  meRight.m
//  touwho_iPad
//
//  Created by apple on 15/8/26.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "meRight.h"

@implementation meRight
#pragma mark - meleft代理
- (void)presentPublish{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"publish" owner:nil options:nil]firstObject];
    [self addSubview:view];
}
- (void)presentPrograms{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UITableView *programs = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    programs.delegate = self;
    programs.dataSource = self;
    [programs registerNib:[UINib nibWithNibName:@"programsCell" bundle:nil] forCellReuseIdentifier:@"programsCell"];
    [self addSubview:programs];

}

- (void)presentApply{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"apply" owner:nil options:nil]firstObject];
    [self addSubview:view];
}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"programsCell" forIndexPath:indexPath];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
