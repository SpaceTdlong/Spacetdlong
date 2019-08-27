//
//  HuGeSPVideoManager.h
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeSPVideoManager : NSObject

/**
 获取电竞视频列表数据
 
 @param page 第几页，从1开始传
 @param isrand  是否随机
 @param success 成功信息
 @param failure 失败信息
 */
+ (void)huGe_dataVideoListWithPage:(NSUInteger)page isrand:(NSInteger )isrand
                    success:(void (^)(NSArray<HuGeSPVideoHomeModel *> *list, BOOL isLoadEnd, NSInteger total))success
                    failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
