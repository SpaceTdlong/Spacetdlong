//
//  HuGeHTTPSessionManager.m
//  DJAppCom
//
//  Created by sam on 2019/5/13.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "HuGeHTTPSessionManager.h"

@implementation HuGeHTTPSessionManager

+ (instancetype)shareManager {
    static HuGeHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HuGeHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[HuGeComManager baseUrl]]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", @"application/xhtml+xml", @"application/xml", @"text/json", @"text/javascript", nil]; //返回可接受数据类型
        manager.requestSerializer.timeoutInterval = 20;
        NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        if (token) {
            [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        }
    });
    return manager;
}

@end
