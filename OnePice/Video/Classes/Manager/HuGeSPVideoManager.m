//
//  HuGeSPVideoManager.m
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeSPVideoManager.h"

@implementation HuGeSPVideoManager

+ (void)huGe_dataVideoListWithPage:(NSUInteger)page isrand:(NSInteger )isrand
                         success:(void (^)(NSArray<HuGeSPVideoHomeModel *> *list, BOOL isLoadEnd, NSInteger total))success
                         failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    http://scrapy.1024group.com/index.php/api/games/video?page=1
    NSString *url = @"index.php/api/games/video";
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(isrand) forKey:@"isrand"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"视频数据： %@",responseObject);

        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeSPVideoHomeListModel *model = [HuGeSPVideoHomeListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
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
