//
//  WDMessageCell.m
//  SuperPhoto
//
//  Created by 222ying on 15/7/15.
//  Copyright (c) 2015年 222ying. All rights reserved.
//    cell 里都是弱的  一些要用到的属性在这初始化；


#import "WDMessageCell.h"
#import "WDMessageModel.h"
#import "WDMessageFrameModel.h"

@interface WDMessageCell()   // 要用到什么控件； 要添加控件的属性在这里加；
 //@property (nonatomic ,weak)  UIButton * imageView;  // 显示的图片


@end




@implementation WDMessageCell

+(instancetype) messageCellWithTableView :(UITableView *) tableview{
    static NSString * ID = @"Cell";
    WDMessageCell* cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



// 一次性的都在这里操作；
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1、时间
        // self.time 是一个弱指针，如果一个实例化出来的对象给了弱指针，那么代码过了这一行 就不存在了；
        UILabel * time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:13.0f];
        time.textColor = [UIColor grayColor];
        [self.contentView addSubview:time]; // 只要加到这个父控件里，父控件在，那么儿子就在；
        self.time = time;
        // 要这样写才行；
        
        // 2、正文
        // self.time 是一个弱指针，如果一个实例化出来的对象给了弱指针，那么代码过了这一行 就不存在了；
        UIButton * textView = [[UIButton alloc]init];
        textView.titleLabel.font = [UIFont systemFontOfSize:15.0f];   //因为这个类型是butten 所以方法有些不一样；
        textView.titleLabel.textColor = [UIColor blackColor];
        textView.titleLabel.numberOfLines = 0 ; // ----》》》。自动换行；；；；
        
        // 设置内边距;
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 10, 20, 10);
        [self.contentView addSubview:textView]; // 只要加到这个父控件里，父控件在，那么儿子就在；
        self.textView = textView;
        
//        // 图片
//        UIButton * imageView = [[UIButton alloc] init];
//        imageView.contentEdgeInsets =UIEdgeInsetsMake(20, 10, 20, 10);
//        [self.contentView addSubview:imageView];
//         self.imageView = imageView;
        
        
        
        // 3、头像
        // self.time 是一个弱指针，如果一个实例化出来的对象给了弱指针，那么代码过了这一行 就不存在了；
        UIImageView * icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon]; // 只要加到这个父控件里，父控件在，那么儿子就在；
        self.icon = icon;
        
        
        // 把cell的背景颜色清空；
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



-(void)setFrameMessage:(WDMessageFrameModel *)frameMessage{
    _frameMessage = frameMessage;
    WDMessageModel * model = frameMessage.message;
    // 1、时间
    self.time.frame = frameMessage.timeF;
    self.time.text = model.time;
    
    // 2、头像
    self.icon.frame = frameMessage.iconF;
    if (model.type == msgMe) {
        self.icon.image = [UIImage imageNamed:@"touxiang"];
    }else{
        self.icon.image = [UIImage imageNamed:@"touhu"];
        
    }
    
//    if ([model.image isEqualToString:@"error"]) {
//        [self.textView setImage:nil forState:UIControlStateNormal]; // 先把图片清空；
        // 3、正文
        // 传入上下左右不需要拉伸的边距。。然后中间 （拉伸、平铺）
        // resizableImageWithCapInsets 返回一张支持拉伸的图片
        UIImage * normal = [UIImage imageNamed:@"chat_send_nor"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(normal.size.height * 0.5f -1, normal.size.width * 0.5f -1, normal.size.height * 0.5f -1, normal.size.width * 0.5f -1)];
        
        
        UIImage * recive = [UIImage imageNamed:@"chat_recive_press_pic"];
        recive = [recive resizableImageWithCapInsets:UIEdgeInsetsMake(recive.size.height * 0.5f -1, recive.size.width * 0.5f -1, recive.size.height * 0.5f -1, recive.size.width * 0.5f -1)];
        
        self.textView.frame = frameMessage.textViewF;
        [self.textView setTitle:model.text forState:UIControlStateNormal];
    
        if (model.type == msgMe) {
            [self.textView setBackgroundImage:normal forState:UIControlStateNormal];
        }else{
            [self.textView setBackgroundImage:recive forState:UIControlStateNormal];
        }
        
  //  }
    
//    
//if ([model.text isEqualToString:@"error"])
//    {
//        // 图片；
//        [self.textView setTitle:nil forState:UIControlStateNormal];   // 先把文字清空；
//        UIImage * normal = [UIImage imageNamed:@"chat_send_nor@2x"];
//        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(normal.size.height * 0.5f -1, normal.size.width * 0.5f -1, normal.size.height * 0.5f -1, normal.size.width * 0.5f -1)];
//        
//        
//        UIImage * recive = [UIImage imageNamed:@"chat_recive_press_pic@2x"];
//        recive = [recive resizableImageWithCapInsets:UIEdgeInsetsMake(recive.size.height * 0.5f -1, recive.size.width * 0.5f -1, recive.size.height * 0.5f -1, recive.size.width * 0.5f -1)];
//        
//        self.textView.frame = frameMessage.imageF;
//         // 拿到沙盒里的图片地址
//        NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString * plistPath = [caches stringByAppendingString:@"/imges"];
//        //先创建这个文件
//
//        
//        // 文件正确位置
//        NSString *file = [plistPath stringByAppendingPathComponent:model.image];
//        NSString *fileName = [file stringByAppendingString:@".png"];
//        
//        NSData *data = [NSData dataWithContentsOfFile:fileName];
////
//        if (data != nil) {
//            [self.textView setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
//            //[self.textView setTitle:model.text forState:UIControlStateNormal];
//            if (model.type == msgMe) {
//                [self.textView setBackgroundImage:normal forState:UIControlStateNormal];
//            }else{
//                [self.textView setBackgroundImage:recive forState:UIControlStateNormal];
//            }
//
//        }else{
//            self.textView.frame = frameMessage.imageF;
//            [self.textView setTitle:@"图片已被删除" forState:UIControlStateNormal];
//            if (model.type == msgMe) {
//                [self.textView setBackgroundImage:normal forState:UIControlStateNormal];
//            }else{
//                [self.textView setBackgroundImage:recive forState:UIControlStateNormal];
//            }
//
//        }
    
//    }
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
