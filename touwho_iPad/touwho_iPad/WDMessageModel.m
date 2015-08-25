//
//  WDMessageModel.m
//  SuperPhoto
//
//  Created by 222ying on 15/7/14.
//  Copyright (c) 2015年 222ying. All rights reserved.
//

#import "WDMessageModel.h"

@implementation WDMessageModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+(instancetype)messageWithDict:(NSDictionary *) dict{
    
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)message{
    NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
    
    
    NSMutableArray * arrayM = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        //[self messageWithDict:dict]  这一步是把字典转为模型；
        [arrayM addObject:[self messageWithDict:dict]];
    }
    return arrayM;
}


@end
