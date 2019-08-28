//
//  HuGeOpenBlackManager.h
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeOpenBlackManager : NSObject

/**
 获取开黑列表数据
 
 @param page 第几页，从1开始传
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataOpenBlackListWithPage:(NSUInteger)page
                               success:(void (^)(NSArray<HuGeOpenBlackUserModel *> *list, BOOL isLoadEnd, NSInteger total))success
                               failure:(void (^)(NSError *error))failure;

/**
 加入房间
 
 @param page 第几页，从1开始传
 @param success 成功信息
 @param failure 失败信息
 */
+(void)huGe_joinRoomWithRoomID:(NSString  *)roomID
                    success:(void (^)(NSString * success))success
                    failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
