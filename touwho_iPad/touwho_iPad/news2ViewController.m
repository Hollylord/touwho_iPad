//
//  news2ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "news2ViewController.h"

@interface news2ViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *article;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomOfInput;


/**
 *  编辑框
 */
@property (weak, nonatomic) IBOutlet UITextView *inputField;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfArticle;
/**
 *  存放所有的评论
 */
@property (nonatomic ,strong) NSMutableArray * messages;

- (IBAction)send:(UIButton *)sender;
@end

@implementation news2ViewController
- (NSMutableArray *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.article.text = @"神低负荷GIS度回复共i。 \r\n 神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。\r\n神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。神低负荷GIS度回复共i。";
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
    
    /**
     *  通知中心,监听键盘
     */
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //任意添加一个
    [self.messages addObject:@"123"];
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
    
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news2Cell" forIndexPath:indexPath];
    UITextView *review = (UITextView *)[cell viewWithTag:3];
    review.text = self.messages[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - 监听键盘Frame变化
-(void)keyboardDidChangeFrame:(NSNotification *)noti{
    
    //拿到键盘的frame
    CGRect frame=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyY =frame.origin.y;   //

    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]; //KEYB的持续时间
    [UIView animateWithDuration:keyDuration animations:^{
        if (keyY != 768) {
            self.bottomOfInput.constant = keyY + 30;
            [self.view layoutIfNeeded];
            
            //滚动到最后一行
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];
            [self.tableview scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else{
            self.bottomOfInput.constant = 0;
            [self.view layoutIfNeeded];
        }
        
    }];
}


#pragma mark - 点击发送
- (IBAction)send:(UIButton *)sender {
    if (self.inputField.text == nil) {
        return ;
    }
    
    [self.messages addObject:self.inputField.text];
    self.inputField.text = nil;
    [self.tableview reloadData];
    //滚动到最后一行
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];
    [self.tableview scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
@end
