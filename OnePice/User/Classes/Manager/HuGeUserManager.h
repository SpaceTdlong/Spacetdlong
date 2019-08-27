//
//  HuGeUserManager.h
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeUserManager : NSObject

//http://scrapy.1024group.com/index.php/api/user/login?account=admin&password=123456
/**
 登录接口
 
 @param account 账户
 @param password 密码
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_djLogWithAccount:(NSString *)account
                       password:(NSString *)password
                    success:(void (^)(BOOL logState))success
                    failure:(void (^)(NSError *error))failure;

/**
 注册接口
 
 @param account 账户
 @param password 密码
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_djRegistWithAccount:(NSString *)account
                   password:(NSString *)password
                         email:(NSString *)email
                        mobile:(NSString *)mobile
                    success:(void (^)(BOOL logState))success
                       failure:(void (^)(NSError *error))failure;

/**
 获取消息列表数据
 

 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataMessageListWithSuccess:(void (^)(NSArray<HuGeUserMessageModel *> *list, BOOL isLoadEnd, NSInteger total))success
                              failure:(void (^)(NSError *error))failure;

/**
 获取用户数据
 
 
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataUserInfotWithSuccess:(void (^)(HuGeUserModel * user, BOOL isLoadEnd, NSInteger total))success
                                failure:(void (^)(NSError *error))failure;


/**
 获取黑名单列表数据
 
 
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataBlackListWithSuccess:(void (^)(NSArray<HuGeUserModel *> *list, BOOL isLoadEnd, NSInteger total))success
                                failure:(void (^)(NSError *error))failure;



/**
 更新信息接口
 
 @param nickname   昵称
 @param bio  简称
 @param avatar  头像
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_updataInfoWithNickname:(NSString *)nickname
                        bio:(NSString *)bio
                           email:(NSString *)email
                          avatar:(NSString *)avatar
                         success:(void (^)(BOOL logState))success
                         failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
