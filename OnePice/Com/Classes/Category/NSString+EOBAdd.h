//
//  NSString+EOBAdd.h
//  EsportGangUp
//
//  Created by sam on 2019/3/7.
//  Copyright © 2019 adc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EOBAdd)

/**
 本身字符串格式：1552021419.690784
 
 输出：
 时间统一格式
 1小时内：  13分钟前
 23小时内： 12小时前
 昨天或前天：  昨天 23:12 或 前天 12:34
 今年内： 05-23
 更早的： 2017-5-13
 
 */
- (NSString *)timeShowString;

/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  补全图片地址
 *
 *  @param url    图片地址
 *
 *  @return 完整地址
 */
+ (NSString *)completionUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
