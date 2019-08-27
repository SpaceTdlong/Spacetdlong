//
//  HuGeCommunityManager.h
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeCommunityManager : NSObject

/**
 获取论坛列表数据
 
 @param page 第几页，从1开始传
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataCommunityListWithPage:(NSUInteger)page
                         success:(void (^)(NSArray<HuGeCommunityModel *> *list, BOOL isLoadEnd, NSInteger total))success
                         failure:(void (^)(NSError *error))failure;

//上传图片
+(void)huGe_uploadAvatar:(NSData *)imgData
               success:(void (^)(NSString * _Nonnull))success
               failure:(void (^)(NSError * _Nonnull))failure;

//发布帖子
+(void)huGe_uploadCommunity:(NSString  *)urll
                  content:(NSString *)content
                  success:(void (^)(NSString * success))success
                  failure:(void (^)(NSError *error))failure;

//上传图片
+(void)huGe_commmLike:(NSString *)isLike
             commID:(NSString *)commid
               success:(void (^)(NSString * success))success
               failure:(void (^)(NSError * failure))failure;

+ (void)huGe_dataCommunityUserListSuccess:(void (^)(NSArray<HuGeCommunityModel *> *list, BOOL isLoadEnd, NSInteger total))success
                             failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
