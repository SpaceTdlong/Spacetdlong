//
//  HuGeCommunityManager.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommunityManager.h"

@implementation HuGeCommunityManager

+ (void)huGe_dataCommunityListWithPage:(NSUInteger)page
                             success:(void (^)(NSArray<HuGeCommunityModel *> *list, BOOL isLoadEnd, NSInteger total))success
                             failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//http://scrapy.1024group.com/index.php/api/forum/flist/
    NSString *url = @"/index.php/api/forum/flist/";
    [params setValue:@(page) forKey:@"page"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"帖子列表数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeCommunityListModel *model = [HuGeCommunityListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
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


+(void)huGe_uploadAvatar:(NSData *)imgData success:(void (^)(NSString * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    NSString *url = @"/index.php/api/common/upload";
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dateString];
        [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress is %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传图片接口： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            
            if (success) {
                BOOL isEnd = YES;
                success([[responseObject objectForKey:@"data"] objectForKey:@"url"]);
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

+(void)huGe_uploadCommunity:(NSString  *)urll
                  content:(NSString *)content
                  success:(void (^)(NSString * success))success
                  failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://scrapy.1024group.com/index.php/api/forum/flist/
    NSString *url = @"/index.php/api/forum/fadd";
    [params setValue:urll forKey:@"image"];
    [params setValue:content forKey:@"content"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"发布帖子数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
           
            
            if (success) {
                success(response.msg);
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

+(void)huGe_commmLike:(NSString *)isLike
             commID:(NSString *)commid
            success:(void (^)(NSString * success))success
            failure:(void (^)(NSError * failure))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://localhost:86/index.php/api/forum/agree?isagree=0&f_id=1
//    /index.php/api/forum/agree?isagree=0&f_id=1
    NSString *url = @"/index.php/api/forum/agree";
    [params setValue:isLike forKey:@"isagree"];
    [params setValue:commid forKey:@"f_id"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"点赞结果数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            if (success) {
                success([responseObject objectForKey:@"msg"]);
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
//http://scrapy.1024group.com/index.php/api/forum/mylist

+ (void)huGe_dataCommunityUserListSuccess:(void (^)(NSArray<HuGeCommunityModel *> *list, BOOL isLoadEnd, NSInteger total))success
                                failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://scrapy.1024group.com/index.php/api/forum/flist/
    NSString *url = @"/index.php/api/forum/mylist";
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"我的帖子列表数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeCommunityListModel *model = [HuGeCommunityListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
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
@end
