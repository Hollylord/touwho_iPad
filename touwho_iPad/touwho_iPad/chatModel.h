//
//  chatModel.h
//  touwho_iPad
//
//  Created by apple on 15/9/9.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  只能存放基本数据类型，图形数据是不行的
 */
@interface chatModel : NSObject

/**
 *  文字
 */
@property (copy,nonatomic) NSString *content;
/**
 *  判断是接收方还是发送方
 */
@property (assign,nonatomic) BOOL isSender;


@end
