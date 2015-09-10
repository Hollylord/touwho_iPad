//
//  sixinViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "sixinViewController.h"
#import <AVOSCloudIM/AVOSCloudIM.h>
#import "chatTableViewCell.h"



@interface sixinViewController () <UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomOfinput;


- (IBAction)sendMessage:(UIButton *)sender;

- (IBAction)cancel:(UIBarButtonItem *)sender;

@property (strong,nonatomic) AVIMConversation *conversation;
@property (strong,nonatomic) AVIMClient *client;
@property (copy,nonatomic) NSString *oldMsgID;
/**
 *  最近接受的消息
 */
@property (strong,nonatomic) NSMutableArray *recentMessages;
/**
 *  所有cell的高度
 */
@property (strong,nonatomic) NSMutableArray *cellHeights;
@end

@implementation sixinViewController
- (NSMutableArray *)cellHeights{
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return  _cellHeights;
}

- (NSMutableArray *)recentMessages{
    if (!_recentMessages) {
        _recentMessages = [NSMutableArray array];
    }
    return _recentMessages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置tableview
    [self.tableView registerNib:[UINib nibWithNibName:@"chatTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //创建聊天客户端
    AVIMClient *imClient = [[AVIMClient alloc] init];
    imClient.delegate = self;
    self.client = imClient;
    [self creatClient];
    
    // 通知中心 在这里；  监听键盘；
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  开启IM客户端
 */
- (void) creatClient{
    [self.client openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error){
        if (error) {
            // 出错了，可能是网络问题无法连接 LeanCloud 云端，请检查网络之后重试。
            // 此时聊天服务不可用。
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"聊天不可用" message:@"123" preferredStyle:UIAlertControllerStyleActionSheet];
            [self presentViewController:alert animated:YES completion:NULL];
        }
        else {
            // 成功登录，可以进入聊天主界面了。
            
            //连接以前的会话
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *conversationID = [user objectForKey:@"conversationID"];
            //查询会话
            if (conversationID) {
                // 新建一个 AVIMConversationQuery 实例
                AVIMConversationQuery *query = [self.client conversationQuery];
                [query whereKey:kAVIMKeyConversationId equalTo:@"55eeb48260b23c9d6ff16fd4"];
                [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
                    //查到了以前的会话
                    if (!error) {
                        self.conversation = objects[0];
                        //查询最近的信息
                        [self.conversation queryMessagesWithLimit:20 callback:^(NSArray *objects, NSError *error) {
                            for (AVIMMessage *message in objects) {
                                [self.recentMessages addObject:message];
                                
                                //通过消息，计算cell的高度
                                NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
                                CGSize msgSize = [message.content boundingRectWithSize:CGSizeMake(400, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
                                NSString *height = [NSString stringWithFormat:@"%f",msgSize.height + 50];
                                [self.cellHeights addObject:height];
                            }
                            
                            [self.tableView reloadData];
                        }];
                    }
                    
                    
                }];
            }
            else{
                //这里私信肯定都是以前的会话 不能创建新会话
                [self creatSession];
            }
            
        }
    }];
}

#pragma mark -
/**
 *  创建新会话
 */
- (void) creatSession{
    // 创建一个包含 Tom、Bob 的新对话
    NSArray *clientIds = [[NSArray alloc] initWithObjects:@"Tom", @"Bob", nil];
    
    // 我们给对话增加一个自定义属性 type，表示单聊还是群聊
    // 常量定义：
    const int kConversationType_OneOne = 0; // 表示一对一的单聊
    [self.client createConversationWithName:nil clientIds:clientIds attributes:@{@"type":[NSNumber numberWithInt:kConversationType_OneOne]} options:AVIMConversationOptionNone
        callback:^(AVIMConversation *conversation, NSError *error) {
    if (error) {
        // 出错了 :(
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"出错了" message:@"123" preferredStyle:UIAlertControllerStyleActionSheet];
        [self presentViewController:alert animated:YES completion:NULL];
    } else {
        // 成功了，进入对话吧
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"会话创建成功" message:@"123" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *okAction  = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:NULL];
        
        self.conversation = conversation;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:conversation.conversationId forKey:@"conversationID"];
        
        
    }
        }];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.recentMessages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    chatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell" forIndexPath:indexPath];
    cell.clientID = self.client.clientId;
  
    cell.message = self.recentMessages[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *height = self.cellHeights[indexPath.row];
    
    return [height floatValue];
}


#pragma mark - 按钮点击
- (IBAction)sendMessage:(UIButton *)sender {
    NSString *str = self.inputField.text;
    self.inputField.text = nil;
    
    AVIMMessage *abc = [AVIMMessage messageWithContent:str];
    [self.conversation sendMessage:abc callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"发送成功");
            
            [self.recentMessages addObject:abc];
            [self.tableView reloadData];
            
        }
    }];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    //结束客户端
    [self.client closeWithCallback:NULL];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - AVIMClientDelegate代理
//接收普通消息
- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message{
    NSLog(@"%@",message.content);
}

#pragma mark - 监听键盘Frame变化
// 监听成功后 会调用的方法；
-(void)keyboardDidChangeFrame:(NSNotification *)noti{
    // transform 平移缩放；
    CGRect frame=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyY =frame.origin.y;   // 键盘的实时Y。
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]; //KEYB的持续时间
    [UIView animateWithDuration:keyDuration animations:^{
        if (keyY != 768) {
            self.bottomOfinput.constant = keyY - 100;
            [self.view layoutIfNeeded];
            
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.recentMessages.count - 1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else{
            self.bottomOfinput.constant = 0;
            [self.view layoutIfNeeded];
        }
        
    }];
}

@end
