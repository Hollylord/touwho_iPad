//
//  news2ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "news2ViewController.h"

@interface news2ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *article;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfArticle;

@end

@implementation news2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.article.text = @"神低负荷GIS度回复共i。  神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。";
    /**
     *  根据内容自动设置textview的高度
     */
    self.article.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    //value:key 这种标准化的字典生成方式不会出错！
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:self.article.font,NSFontAttributeName, nil];

    CGSize textSize = [self.article.text boundingRectWithSize:CGSizeMake(400, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    self.heightOfArticle.constant = textSize.height;
    //切记改变了约束以后要立马下一句
    [self.article layoutIfNeeded];
    
    /**
     *  注册tableviewCell
     */
    [self.tableview registerNib:[UINib nibWithNibName:@"news2Cell" bundle:nil] forCellReuseIdentifier:@"news2Cell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news2Cell" forIndexPath:indexPath];
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



@end
