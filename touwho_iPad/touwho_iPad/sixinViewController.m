//
//  sixinViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/8.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "sixinViewController.h"
#import <AVOSCloudIM/AVOSCloudIM.h>



@interface sixinViewController () <UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputField;

- (IBAction)sendMessage:(UIButton *)sender;

- (IBAction)cancel:(UIBarButtonItem *)sender;

@property (strong,nonatomic) AVIMConversation *conversation;
@property (strong,nonatomic) AVIMClient *client;
@end

@implementation sixinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sixinCell"];
    
    //开启聊天客户端
    AVIMClient *imClient = [[AVIMClient alloc] init];
    imClient.delegate = self;
    self.client = imClient;
    
    [imClient openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error){
        if (error) {
            // 出错了，可能是网络问题无法连接 LeanCloud 云端，请检查网络之后重试。
            // 此时聊天服务不可用。
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"聊天不可用" message:@"123" preferredStyle:UIAlertControllerStyleActionSheet];
            [self presentViewController:alert animated:YES completion:NULL];
        } else {
            // 成功登录，可以进入聊天主界面了。
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *conversationID = [user objectForKey:@"conversationID"];
            if (conversationID) {
                //查询会话
                // 新建一个 AVIMConversationQuery 实例
            AVIMConversationQuery *query = [[AVIMClient defaultClient] conversationQuery];
            [query getConversationById:conversationID callback:^(AVIMConversation *conversation, NSError *error) {
                    NSLog(@"%@",conversation);
                    //查到了会话
                    if (conversation) {
                        NSLog(@"%@",conversation.conversationId);
                        
                    }
                    //没有查到则创建会话
                    else{
                        [self creatSession];
                    }
                }];
            }
            else{
                [self creatSession];
            }

        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) creatSession{
    // 创建一个包含 Tom、Bob 的新对话
    NSArray *clientIds = [[NSArray alloc] initWithObjects:@"Tom", @"Bob", nil];
    
    // 我们给对话增加一个自定义属性 type，表示单聊还是群聊
    // 常量定义：
    const int kConversationType_OneOne = 0; // 表示一对一的单聊
    const int kConversationType_Group = 1;  // 表示多人群聊
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
    
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sixinCell" forIndexPath:indexPath];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


#pragma mark - 按钮点击
- (IBAction)sendMessage:(UIButton *)sender {
    NSString *str = self.inputField.text;
    self.inputField.text = nil;
    
    AVIMMessage *abc = [AVIMMessage messageWithContent:str];
    [self.conversation sendMessage:abc callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"发送成功");
        }
    }];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    //结束客户端
    [self.client closeWithCallback:NULL];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - AVIMClientDelegate代理
- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message{
    NSLog(@"%@",message.content);
}
@end
