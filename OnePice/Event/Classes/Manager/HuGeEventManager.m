//
//  HuGeEventManager.m
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeEventManager.h"

@implementation HuGeEventManager

+ (void)huGe_dataEventListWithPage:(NSUInteger)page type:(NSString *)type
                         success:(void (^)(NSArray<HuGeEventModel *> *list, BOOL isLoadEnd, NSInteger total))success
                         failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //    http://scrapy.1024group.com/index.php/api/games/video?page=1
    NSString *url = @"index.php/api/games/schedule";
    [params setValue:@(page) forKey:@"page"];
    [params setValue:type forKey:@"type"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"赛事数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeEventListModel *model = [HuGeEventListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
            if (success) {
                BOOL isEnd = model.last_page == page ? YES : NO;
                success(model.list, isEnd, model.total);
            }
        } else {
            if (failure) {
                NSError *error = [NSError errorWithDomain:response.msg code:response.error userInfo:nil];
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

@end
