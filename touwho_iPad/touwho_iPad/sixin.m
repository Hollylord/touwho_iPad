//
//  sixin.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "sixin.h"


#define API_KEY @"mheb5yGoOkbOihOikcOjhnt1" // 请修改为您在百度开发者平台申请的API_KEY
#define SECRET_KEY @"b65db23549102b069a9e7851aaa18669" // 请修改您在百度开发者平台申请的SECRET_KEY

@implementation sixin

- (void)awakeFromNib{
    UINib *nib = [UINib nibWithNibName:@"sixinCell" bundle:nil];
    [self.talks registerNib:nib forCellReuseIdentifier:@"sixinCell"];
    [self.replyView registerNib:nib forCellReuseIdentifier:@"sixinCell"];
    
    self.replyView.allowsSelection = YES;  // 不能点击；
    self.replyView.backgroundColor = [UIColor colorWithRed:225/225.0 green:225/225.0 blue:225/225.0 alpha:1.0];
    self.replyView.separatorStyle = UITableViewCellSeparatorStyleNone;  // 去横杠。
    // 成为文本框的代理；
    self.inputView.delegate = self;

    // 将messageplist文件保存到沙河的caches文件夹中
    [WDMessageTool copyMessages];
    // 将autoplist文件保存到沙河的caches文件夹中
    [WDMessageTool copyautoReplay];

    // 通知中心 在这里；  监听键盘；
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter]; //单例；
    
    // 监听 监听者 ；添加监听者；
    [center addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
    // 键盘里的输入框  --  左边的定格；
    self.inputView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, 0)];
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    
    // 让Tableview滚到最后一行；
    NSIndexPath * path = [NSIndexPath indexPathForRow:self.messages.count -1  inSection:0];
    [self.replyView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.replyView]) {
        return self.messages.count;
    }
    else{
        return 4;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.replyView]) {
        WDMessageCell * cell = [WDMessageCell messageCellWithTableView:tableView];
        
        WDMessageFrameModel * FrameModel = self.messages[indexPath.row]; // 取出来而已
        
        cell.frameMessage = FrameModel;  // 这里就是一次过赋值；
        
        cell.textView.tag = indexPath.row; // 绑定了方便监听
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 点击没有颜色
      
        return cell;

    }
    else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sixinCell" forIndexPath:indexPath];
    
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.replyView]) {
        WDMessageFrameModel * model = self.messages[indexPath.row];
        return model.cellH;
    }
    else{
        return 100;
    }
}

#pragma mark - 百度语音回调
- (void)onEndWithViews:(BDRecognizerViewController *)aBDRecognizerView withResults:(NSArray *)aResults
{
    self.inputView.text = nil;
    
    if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
    {
        // 搜索模式下的结果为数组，示例为
        // ["公园", "公元"]
        NSMutableArray *audioResultData = (NSMutableArray *)aResults;
        NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
        tmpString = aResults[0];
        //        for (int i=0; i < [audioResultData count]; i++)
        //        {
        //            [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
        //        }
        
        self.inputView.text = [self.inputView.text stringByAppendingString:tmpString];
        //self.inputView.text = [self.inputView.text stringByAppendingString:@"\n"];
        // NSLog(@"%@",tmpString)
        
    }
    else
    {
      
        NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aResults];
        
        self.inputView.text = [self.inputView.text stringByAppendingString:tmpString];
        self.inputView.text = [self.inputView.text stringByAppendingString:@"\n"];
    }
}


#pragma mark - 按钮点击
- (IBAction)send:(UIButton *)sender {
    if ([self.inputView.text isEqualToString:@""] || self.inputView.text==nil) {
        return;
    }
    
    
    //    // 1 .发送一条数据
    [self addMEssage: self.inputView.text type:msgMe];
    
    //    // 2 .自动回复
    if ([self autoReplayWithType: self.inputView.text] != nil ) {
        [self addMEssage: [self autoReplayWithType: self.inputView.text] type:msgrobot];
    }
    
    // 4. 清空表格；
    self.inputView.text = nil;
    
    // 退出编辑时间；
    if(self.messages.count < 5){
        [self endEditing:YES];
    }

}

- (IBAction)toggleKey:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.talkBtn.hidden = YES;
        self.inputView.hidden = NO;
    }
    
    else{
        self.talkBtn.hidden = NO;
        self.inputView.hidden = YES;
    }

}

- (IBAction)talk:(UIButton *)sender {
    self.inputView.hidden = NO;
    self.talkBtn.hidden = YES;
    self.toggleBtn.selected = YES;
    //让键盘下去
    [self.inputView resignFirstResponder];
    BDRecognizerViewController *recognizerViewController = [[BDRecognizerViewController alloc] initWithOrigin:CGPointMake(35, 250) withTheme:[BDTheme defaultTheme]];
    
    if ([[UIScreen mainScreen] bounds].size.width > 375) {
       
        recognizerViewController = [[BDRecognizerViewController alloc] initWithOrigin:CGPointMake(58, 250) withTheme:[BDTheme defaultTheme]];
        
    }
    
    
    recognizerViewController.enableFullScreenMode = NO; //设置是否全屏模式
    recognizerViewController.delegate = self;
    self.recognizerViewController = recognizerViewController;
    
    
    // 设置识别参数
    BDRecognizerViewParamsObject *paramsObject = [[BDRecognizerViewParamsObject alloc] init];
    
    // 开发者信息，必须修改API_KEY和SECRET_KEY为在百度开发者平台申请得到的值，否则示例不能工作
    paramsObject.apiKey = API_KEY;
    paramsObject.secretKey = SECRET_KEY;
    
    // 设置是否需要语义理解，只在搜索模式有效
    paramsObject.isNeedNLU = [BDVRSConfig sharedInstance].isNeedNLU;
    
    // 设置识别语言
    paramsObject.language = [BDVRSConfig sharedInstance].recognitionLanguage;
    
    // 设置识别模式，分为搜索和输入
    paramsObject.recogPropList = @[[BDVRSConfig sharedInstance].recognitionProperty];
    
    
    
    paramsObject.tipsTitle = @"请说话";
    
    paramsObject.resultShowMode = BDRecognizerResultShowModeContinuousShow;
    
    paramsObject.isShowTipAfter3sSilence = NO;
    paramsObject.isShowHelpButtonWhenSilence = NO;
    paramsObject.tipsTitle = @"可以使用如下指令记账";
    paramsObject.tipsList = [NSArray arrayWithObjects:@"我要记账", @"买苹果花了十块钱", @"买牛奶五块钱", @"第四行滚动后可见", @"第五行是最后一行", nil];
    
    
    
    // 设置城市ID，当识别属性包含EVoiceRecognitionPropertyMap时有效
    paramsObject.cityID = 1;
    
    [recognizerViewController startWithParams:paramsObject];

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
            self.bottomOfInput.constant = keyY + 30;
            [self layoutIfNeeded];
            
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];
            [self.replyView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else{
            self.bottomOfInput.constant = 0;
            [self layoutIfNeeded];
        }
        
    }];
}

#pragma mark  - send TextField的代理方法; 点击右下角的send按钮、、
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.inputView.text isEqualToString:@""] || self.inputView.text==nil) {
        return YES;
    }
    
    
    // 1 .发送一条数据
    [self addMEssage:textField.text type:msgMe];
    
    // 2 .自动回复
    if ([self autoReplayWithType:textField.text] != nil ) {
        [self addMEssage: [self autoReplayWithType:textField.text] type:msgrobot];
    }
    
    // 4. 清空表格；
    self.inputView.text = nil;
    
    // 退出编辑时间；
    if(self.messages.count < 5){
        [self endEditing:YES];
    }
    
    
    return YES;  // 直接给一个yes;
}
// 屏幕拖动的时候；然后就取消编辑事件；
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endEditing:YES];
}
#pragma mark  - 按下send按钮后addMEssage的实现
// 添加一条聊天信息到聊天里
-(void)addMEssage:(NSString *)text type:(MessageModelType)type{
    // 1.添加模型数据;
    WDMessageModel *message = [[WDMessageModel alloc]init];
    //
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    //
    WDMessageFrameModel * lastFm = [self.messages lastObject];
    message.hideTime = [locationString isEqualToString:lastFm.message.time ];
    
    message.time = locationString;
    message.text = text;
    message.type = type;
    // message.image = @"error";
    
    // 2。存到数组里去；
    WDMessageFrameModel *fm = [[WDMessageFrameModel alloc]init];
    fm.message = message;
    //
    [self.messages addObject:fm];
    
    //    // 顺便加载本地的plist里去；
    [WDMessageTool addMessage:fm.message];
    
    
    //3 。 刷新表格；
    [self.replyView reloadData];
    
    // 自动上移动；
    // 滚到最后一行；
    NSIndexPath * path = [NSIndexPath indexPathForRow:self.messages.count -1  inSection:0];
    [self.replyView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
// 自动回复一条聊天信息的方法抽出来；
#pragma mark - 自动回复懒加载
-(NSDictionary *)autoReplay{
    if (_autoReplay == nil) {
        NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString * plistPath = [caches stringByAppendingString:@"/Plist"];
        // 文件正确位置
        NSString *fileName = [plistPath stringByAppendingPathComponent:@"autoReplay.plist"];
        _autoReplay = [NSDictionary dictionaryWithContentsOfFile:fileName];
        
    }
    return _autoReplay;
}


//NSMutableArray * messages;   好了以后要懒加载；；  懒加载可以对比前后的某两个属性；
-(NSMutableArray * )messages{
    if (nil == _messages) {
        NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString * plistPath = [caches stringByAppendingString:@"/Plist"];
        NSString *fileName = [plistPath stringByAppendingPathComponent:@"messages.plist"];
        NSArray * array = [NSArray arrayWithContentsOfFile:fileName];
        
        NSMutableArray *messageArr = [NSMutableArray array];
        
        for (NSDictionary * dict in array) {
            //[MessageModel messageWithDict:dict]  这一步是把字典转为模型；
            WDMessageModel * message = [WDMessageModel messageWithDict:dict];
            // 这里是比较 是否要显示时间；
            WDMessageFrameModel * lastFm = [messageArr lastObject];
            message.hideTime = [message.time isEqualToString:lastFm.message.time ];
            //
            WDMessageFrameModel * fm = [[WDMessageFrameModel alloc]init];
#warning 这里设置了messages的Frame;fm.message = message;不仅仅是设置了数值；通过数值连同frame一起设置；
            fm.message = message;
            
            [messageArr addObject:fm];
        }
        _messages = messageArr;
    }
    return _messages;
    
}




-(NSString * )autoReplayWithType:(NSString *)text{
    for (int a = 0; a < text.length; a++) {
        NSString * subStr = [text substringWithRange:NSMakeRange(a, 1)];
        if (self.autoReplay[subStr]) {   // 如果这个key有值那么久进去，我们就把这个key赋值给这个str;
            return self.autoReplay[subStr];
        }
    }
    NSString *file = [@"是的，" stringByAppendingString:text];
    return file;
}

@end
