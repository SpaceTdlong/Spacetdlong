//
//  HuGeUserManager.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserManager.h"

@implementation HuGeUserManager

+ (void)huGe_djLogWithAccount:(NSString *)account
                   password:(NSString *)password
                    success:(void (^)(BOOL logState))success
                    failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *url = @"index.php/api/user/login";
    [params setValue:account forKey:@"account"];
    [params setValue:password forKey:@"password"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            
            if (success) {
                NSString *str = [[[responseObject objectForKey:@"data"] objectForKey:@"userinfo"] objectForKey:@"token"];
                NSLog(@"token == %@",str);
                [[NSUserDefaults standardUserDefaults] setObject:[[[responseObject objectForKey:@"data"] objectForKey:@"userinfo"] objectForKey:@"token"] forKey:@"token"];
                BOOL state = true;
                success(state);
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
+ (void)huGe_djRegistWithAccount:(NSString *)account
                      password:(NSString *)password
                         email:(NSString *)email
                        mobile:(NSString *)mobile
                       success:(void (^)(BOOL logState))success
                       failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    http://scrapy.1024group.com/index.php/api/user/register?username=zhenglm&password=123456&email=1234567@qq.com&mobile=18650178965
    NSString *url = @"/index.php/api/user/register";
    [params setValue:account forKey:@"username"];
    [params setValue:password forKey:@"password"];
    [params setValue:email forKey:@"email"];
    [params setValue:mobile forKey:@"mobile"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            
            if (success) {
                BOOL state = true;
                success(state);
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
+ (void)huGe_dataMessageListWithSuccess:(void (^)(NSArray<HuGeUserMessageModel *> *list, BOOL isLoadEnd, NSInteger total))success
                              failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://scrapy.1024group.com/index.php/api/forum/flist/
    NSString *url = @"/index.php/api/forum/message";
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"消息列表数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeUserMessageListModel *model = [HuGeUserMessageListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
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
+ (void)huGe_dataUserInfotWithSuccess:(void (^)(HuGeUserModel * user, BOOL isLoadEnd, NSInteger total))success
                              failure:(void (^)(NSError *error))failure{
    NSString *url = @"/index.php/api/user/index";
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"userInfo:数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeUserModel *model = [HuGeUserModel yy_modelWithDictionary:[[responseObject objectForKey:@"data"] objectForKey:@"welcome"]];
            
            if (success) {
                BOOL isEnd = YES;
                success(model, isEnd, 1);
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


+ (void)huGe_dataBlackListWithSuccess:(void (^)(NSArray<HuGeUserModel *> *list, BOOL isLoadEnd, NSInteger total))success
                              failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://scrapy.1024group.com/index.php/api/forum/flist/
    NSString *url = @"/index.php/api/user/blacklist";
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"黑名单列表数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeUserListModel *model = [HuGeUserListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
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

+ (void)huGe_updataInfoWithNickname:(NSString *)nickname
                                bio:(NSString *)bio
                              email:(NSString *)email
                             avatar:(NSString *)avatar
                            success:(void (^)(BOOL logState))success
                            failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //    http://scrapy.1024group.com/index.php/api/user/register?username=zhenglm&password=123456&email=1234567@qq.com&mobile=18650178965
    NSString *url = @"/index.php/api/user/profile";
    [params setValue:nickname forKey:@"nickname"];
    [params setValue:bio forKey:@"bio"];
    [params setValue:email forKey:@"email"];
    [params setValue:avatar forKey:@"avatar"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            
            if (success) {
                BOOL state = true;
                success(state);
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
