//
//  NSDate+EOBExtension.h
//  EsportGangUp
//
//  Created by yunrong liu  on 2019/3/7.
//  Copyright © 2019 adc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (EOBExtension)
+ (NSString *)getDateStringFromTimestamp:(NSTimeInterval)time;
/**
 *  将时间戳转成自定义的格式
 */
+ (NSString *)customFormatWithTimeSp:(long long)timeSp;
@end

NS_ASSUME_NONNULL_END
