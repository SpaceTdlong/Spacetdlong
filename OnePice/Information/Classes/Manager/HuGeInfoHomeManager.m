//
//  HuGeInfoHomeManager.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeInfoHomeManager.h"

@implementation HuGeInfoHomeManager

+(void)huGe_dataListWithPage:(NSUInteger)page type:(NSString *)type success:(void (^)(NSArray<HuGeInfoHomeModel *> * _Nonnull, BOOL, NSInteger))success failure:(void (^)(NSError * _Nonnull))failure{
//    http://scrapy.1024group.com/index.php/api/games/news?offset=1&type=1
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        NSString *url = @"index.php/api/games/news";
        [params setValue:@(page) forKey:@"page"];
        [params setValue:type forKey:@"type"];
        [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
            if (response.code == 1) {
                HuGeInfoListModel *model = [HuGeInfoListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
                
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
