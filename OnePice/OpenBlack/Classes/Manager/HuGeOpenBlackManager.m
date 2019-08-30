//
//  HuGeOpenBlackManager.m
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackManager.h"

@implementation HuGeOpenBlackManager

+ (void)huGe_dataOpenBlackListWithPage:(NSUInteger)page
                               success:(void (^)(NSArray<HuGeOpenBlackRoomModel *> *list, BOOL isLoadEnd, NSInteger total))success
                               failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://scrapy.1024group.com/index.php/api/forum/flist/
    NSString *url = @"/index.php/api/room/rlist";
    [params setValue:@(page) forKey:@"page"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"开黑列表数据： %@",responseObject);
        
        
        HuGeResponseModel *response = [HuGeResponseModel yy_modelWithDictionary:responseObject];
        if (response.code == 1) {
            HuGeOpenBlackRoomListModel *model = [HuGeOpenBlackRoomListModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
            
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

+(void)huGe_joinRoomWithRoomID:(NSString  *)roomID
                       success:(void (^)(NSString * success))success
                       failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://scrapy.1024group.com/index.php/api/room/joinroom?r_id=1&phone=18655667766&qq=23456544

    NSString *url = @"/index.php/api/room/joinroom";
    [params setValue:roomID forKey:@"r_id"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"加入房间数据： %@",responseObject);
        
        
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



+(void)huGe_creatRoomWithRoom_name:(NSString  *)room_name
                        room_type:(NSString  *)room_type
                            brief:(NSString  *)brief
                       start_time:(NSString  *)start_time
                          success:(void (^)(NSString * success))success
                          failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //http://scrapy.1024group.com/index.php/api/room/joinroom?r_id=1&phone=18655667766&qq=23456544
    
    NSString *url = @"/index.php/api/room/addroom";
    [params setValue:room_name forKey:@"room_name"];
    [params setValue:room_type forKey:@"room_type"];
    [params setValue:brief forKey:@"brief"];
    [params setValue:start_time forKey:@"start_time"];
    [[HuGeHTTPSessionManager shareManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"创建房间数据： %@",responseObject);
        
        
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
@end
