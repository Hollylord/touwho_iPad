//
//  WDMessageTool.m
//  SuperPhoto
//
//  Created by 222ying on 15/7/16.
//  Copyright (c) 2015年 222ying. All rights reserved.
//

#import "WDMessageTool.h"
#import "WDMessageFrameModel.h"
#import "WDMessageModel.h"

@implementation WDMessageTool


+(BOOL)addMessage:(WDMessageModel *)message{

    
    NSNumber * num = @1;
    if (message.type == msgMe) {
        num = @0;
    }
    
   NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
   NSString * plistPath = [caches stringByAppendingString:@"/Plist"];

     //先创建这个文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
  [fileManager createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:nil];
    // 文件正确位置
    NSString *fileName = [plistPath stringByAppendingPathComponent:@"messages.plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:message.text,@"text",message.time,@"time",num,@"type", nil];
    

    // 读出来；
    NSMutableArray *messageArr = [NSMutableArray arrayWithContentsOfFile:fileName];
    // 改
    [messageArr addObject:dict];


    
//写入文件

    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fileName] ==YES) {
        [messageArr writeToFile:fileName atomically:YES];
        return YES;
    }else{
        return NO;
    }
}


+(BOOL)addALLMessage:(NSMutableArray *)allMessage{
        
    NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * plistPath = [caches stringByAppendingString:@"/Plist"];
    
    //先创建这个文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:nil];
    // 文件正确位置
    NSString *fileName = [plistPath stringByAppendingPathComponent:@"messages.plist"];
    
    [WDMessageTool copyMessages]; //少了这句就写入不成功，傻逼了；
    // 读出来；
    NSMutableArray *messageArr = [[NSMutableArray alloc]init];
    // 改
    
    for (WDMessageFrameModel * fm in allMessage) {
        WDMessageModel * message = fm.message;
        NSNumber * num = @1;
        if (message.type == msgMe) {
            num = @0;
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:message.text,@"text",message.time,@"time",num,@"type", nil];
        [messageArr addObject:dict];
    }
    
    //写入文件
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fileName] ==YES) {
        [messageArr writeToFile:fileName atomically:YES];
        return YES;
    }else{
        return NO;
    }
}






+(BOOL)addAutoReplay:(NSDictionary *)dict{
    NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * plistPath = [caches stringByAppendingString:@"/Plist"];
    
    //先创建这个文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:nil];
    // 文件正确位置
    NSString *fileName = [plistPath stringByAppendingPathComponent:@"autoReplay.plist"];
    // 读出来；
    NSMutableDictionary *dictOri = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
        // 改
    [dictOri addEntriesFromDictionary:dict];
    
    //写入文件
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fileName] ==YES) {
        [dictOri writeToFile:fileName atomically:YES];
        return YES;
    }else{
        return NO;
    }

}




+(BOOL) copyMessages{
    NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * plistPath = [caches stringByAppendingString:@"/Plist"];
    
    //先创建这个文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:nil];
    // 文件正确位置
    NSString *fileName = [plistPath stringByAppendingPathComponent:@"messages.plist"];
    
    
    NSFileManager *copyMsgPlist = [NSFileManager defaultManager];
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    
    NSError *error =nil;
    [copyMsgPlist copyItemAtPath:bundle toPath:fileName error:&error];
    if (error) {
        return NO;
    }else{
        return YES;
    }

    
}

+(BOOL) copyautoReplay{
    
    
    NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * plistPath = [caches stringByAppendingString:@"/Plist"];
    
    //先创建这个文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:nil];
    // 文件正确位置
    NSString *fileName = [plistPath stringByAppendingPathComponent:@"autoReplay.plist"];
    
    
    NSFileManager *copyMsgPlist = [NSFileManager defaultManager];
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"autoReplay" ofType:@"plist"];
    
    NSError *error =nil;
    [copyMsgPlist copyItemAtPath:bundle toPath:fileName error:&error];
    if (error) {
        return NO;
    }else{
        return YES;
    }
    
    
}





+(NSArray *) messages{
//    NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
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
        fm.message = message;
        [messageArr addObject:fm];
    }
        
        return messageArr;

}

+(NSDictionary *)autoReplay{
    NSString * caches =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * plistPath = [caches stringByAppendingString:@"/Plist"];
    // 文件正确位置
    NSString *fileName = [plistPath stringByAppendingPathComponent:@"autoReplay.plist"];

    
   NSDictionary * autoReplay = [NSDictionary dictionaryWithContentsOfFile:fileName];
    return autoReplay;
}




@end