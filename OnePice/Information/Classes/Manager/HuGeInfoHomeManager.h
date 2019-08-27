//
//  HuGeInfoHomeManager.h
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HuGeResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HuGeInfoHomeManager : NSObject

/**
 获取兼职资讯列表数据
 
 @param page 第几页，从1开始传
 @param type 游戏种类
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataListWithPage:(NSUInteger)page
                   type:(NSString *)type
                    success:(void (^)(NSArray<HuGeInfoHomeModel *> *list, BOOL isLoadEnd, NSInteger total))success
                    failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
