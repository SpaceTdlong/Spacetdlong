//
//  NSString+EOBAdd.m
//  EsportGangUp
//
//  Created by sam on 2019/3/7.
//  Copyright © 2019 adc. All rights reserved.
//

#import "NSString+EOBAdd.h"

@implementation NSString (EOBAdd)


- (NSString *)timeShowString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
    
    //得到与当前时间差
    NSTimeInterval time = date.timeIntervalSinceNow;
    
    NSString *returnString = nil;
    
    if (time > 3600*24) {
        // 一天后，几月几号
        returnString = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else if (time > 3600) {
        // 一天内，几个小时后
        returnString = [NSString stringWithFormat:@"%.0f小时后",fabs(time)/3600];
    } else if (time > 60) {
        // 一个小时内，几分钟后
        returnString = [NSString stringWithFormat:@"%.0f分钟后",fabs(time)/60];
    } else if (time > 0) {
        // 几秒后
        returnString = [NSString stringWithFormat:@"%.0f秒后",fabs(time)];
    }else if (time > -60) {
        returnString = @"刚刚";
    } else if (time > -3600) {
        returnString = [NSString stringWithFormat:@"%.0f分钟前",fabs(time)/60];
    } else if (time > -3600 * 24) {
        returnString = [NSString stringWithFormat:@"%.0f小时前",fabs(time)/3600];
    } else {
        // 一天前，几月几号
        returnString = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return returnString;
}


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

+ (NSString *)completionUrl:(NSString *)url{
    if (![url hasPrefix:@"http"]) {
        url = [[HuGeComManager baseUrl] stringByAppendingString:url];
    }
    return url;
}
@end
