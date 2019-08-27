//
//  NSDictionary+ESAdd.m
//  LDJDSGame
//
//  Created by sam on 2018/9/13.
//  Copyright © 2018年 heiya. All rights reserved.
//

#import "NSDictionary+ESAdd.h"

@implementation NSDictionary (ESAdd)

- (NSDictionary *)exchangeKeyValue {
    NSMutableDictionary *exchangeDic = [[NSMutableDictionary alloc] init];
    for (NSUInteger i = 0; i < self.allKeys.count; i++) {
        NSString *key = self.allKeys[i];
        NSString *value = self[key];
        [exchangeDic setValue:key forKey:value];
    }
    return exchangeDic;
}


- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end
