//
//  HuGeCommentManager.h
//  OnePice
//
//  Created by edz on 2019/8/19.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeCommentManager : NSObject


/**
 发送电竞评论
 
 @param type     类型
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataPostCommentWithid:(NSString *)ID type:(NSString *)type
                         content:(NSString *)content
                         success:(void (^)(BOOL logState))success
                         failure:(void (^)(NSError *error))failure;


//http://scrapy.1024group.com/index.php/api/comment/clist?type=1&id=1
/**
 获取评论内容列表
 
 @param ID       评论关联ID
 @param type     赛事游戏类型
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataCommonsListWithID:(NSString *)ID type:(NSString *)type
                         success:(void (^)(NSArray<HuGeCommentModel *> *list, BOOL isLoadEnd, NSInteger total))success
                         failure:(void (^)(NSError *error))failure;


//拉黑接口
+ (void)huGe_shieldWithID:(NSString *)ID
                success:(void (^)(BOOL logState))success
                failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
