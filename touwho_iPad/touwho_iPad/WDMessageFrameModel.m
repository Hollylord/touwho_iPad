//
//  WDMessageFrameModel.m
//  SuperPhoto
//
//  Created by 222ying on 15/7/14.
//  Copyright (c) 2015年 222ying. All rights reserved.
//

#import "WDMessageFrameModel.h"
#import "WDMessageModel.h"


#define kScreenWidth [[UIScreen mainScreen]bounds].size.width
#define kNormalH 44
#define kIconW 50
#define kIconH 50
#define kBtnFont [UIFont systemFontOfSize:14.0f]



@implementation WDMessageFrameModel
-(void)setMessage:(WDMessageModel *)message{
    _message = message;  // 如果是set方法。如果没加上这一行，那么model里面就没有值；不加这一行出了这个方法就没值了
    CGFloat padding = 10;
    // 1、时间
    
    if (message.hideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = kScreenWidth;
        CGFloat timeH = kNormalH;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 2、头像
    CGFloat iconX;
    if (message.type == msgMe) { //自己发的
        iconX = kScreenWidth - padding - kIconW;
    }else{ //别人发的；
        iconX = padding;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = kIconW;
    CGFloat iconH = kIconH;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 3、正文
    CGFloat textViewX;
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    if ([[UIScreen mainScreen] bounds].size.width > 375) {
        
        textMaxSize = CGSizeMake(240, MAXFLOAT);
    }
    
    CGSize textSize = [message.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;
    
    if (message.type == msgMe) { //自己发的
        textViewX = kScreenWidth -padding*2 - kIconW - textSize.width-40;
    }else{ //别人发的；
        textViewX = padding*2 + kIconW;
    }
    
    CGFloat textViewY = iconY; //Y等于头像的Y；
    CGFloat textViewW = textSize.width;
    CGFloat textViewH = textSize.height;
    _textViewF = CGRectMake(textViewX, textViewY, textViewW + 40, textViewH+40);
//    
//    // 图片
//    CGFloat imageX;
//    if (message.type == msgMe) { //自己发的
//        imageX = 105;//kScreenWidth -padding*2 - kIconW - textSize.width-40;
//    }else{ //别人发的；
//        imageX = padding*2 + kIconW;
//    }
//    
//    CGFloat imageY = iconY; //Y等于头像的Y；
//    CGFloat imageW = 150;
//    CGFloat imageH = 150;
//    _imageF = CGRectMake(imageX, imageY, imageW, imageH);
//    
    
    // 4、cell高度
    
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textViewMaxY = CGRectGetMaxY(_textViewF);
    CGFloat imageMaxY = 0;
//    if ([message.text isEqualToString:@"error"]) {
//        imageMaxY = CGRectGetMaxY(_imageF);
//    }
    
    _cellH = MAX(MAX(iconMaxY, textViewMaxY),imageMaxY);
}


@end
