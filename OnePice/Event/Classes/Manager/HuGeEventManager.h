//
//  HuGeEventManager.h
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeEventManager : NSObject

/**
 获取列表数据电竞赛事
 
 @param page 第几页，从1开始传
 @param type     赛事游戏类型
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataEventListWithPage:(NSUInteger)page type:(NSString *)type
                         success:(void (^)(NSArray<HuGeEventModel *> *list, BOOL isLoadEnd, NSInteger total))success
                         failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
