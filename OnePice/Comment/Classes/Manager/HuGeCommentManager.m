//
//  HuGeCommentManager.m
//  OnePice
//
//  Created by edz on 2019/8/19.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommentManager.h"

@implementation HuGeCommentManager

+ (void)huGe_dataPostCommentWithid:(NSString *)ID type:(NSString *)type
                         content:(NSString *)content
                         success:(void (^)(BOOL logState))success
                         failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //    http://scrapy.1024group.com/index.php/api/games/video?page=1
    NSString *url = @"/index.php/api/comment/cadd";
    [params setValue:ID forKey:@"id"];
    [params setValue:type forKey:@"type"];
    [params setValue:content forKey:@"content"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"发布评论结果： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            
            if (success) {
                BOOL state = true;
                success(state);
            }
        }  else {
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

+ (void)huGe_dataCommonsListWithID:(NSString *)ID type:(NSString *)type
                         success:(void (^)(NSArray<HuGeCommentModel *> *list, BOOL isLoadEnd, NSInteger total))success
                         failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //    http://scrapy.1024group.com/index.php/api/games/video?page=1
    NSString *url = @"index.php/api/comment/clist";
    [params setValue:ID forKey:@"id"];
    [params setValue:type forKey:@"type"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"赛事评论数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeCommentListModel *model = [HuGeCommentListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
            if (success) {
                BOOL isEnd = YES;
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
+ (void)huGe_shieldWithID:(NSString *)ID
                success:(void (^)(BOOL logState))success
                failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //    http://scrapy.1024group.com/index.php/api/games/video?page=1
    NSString *url = @"/index.php/api/comment/black";
    [params setValue:ID forKey:@"u_id"];

    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"拉黑结果： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            
            if (success) {
                BOOL state = true;
                success(state);
            }
        }  else {
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
