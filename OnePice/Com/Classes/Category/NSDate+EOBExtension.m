//
//  NSDate+EOBExtension.m
//  EsportGangUp
//
//  Created by yunrong liu  on 2019/3/7.
//  Copyright © 2019 adc. All rights reserved.
//

#import "NSDate+EOBExtension.h"

@implementation NSDate (EOBExtension)

+ (NSString *)getDateStringFromTimestamp:(NSTimeInterval)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [date stringWithFormat:@"yyyy.MM.dd HH:mm"];
}

/**
 *  将时间戳转成自定义的格式
 */
+ (NSString *)customFormatWithTimeSp:(long long)timeSp {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:timeSp];
    NSString *create_time = [fmt stringFromDate:create];
    
    if (create.isThisYear) {
        //今年
        if (create.isToday) {
            // 今天
            //            ZFLog(@"%@---%@",[NSDate date],create);
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { //1分钟内
                return @"刚刚";
            }
        } else if (create.isYesterday) {
            // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        } else {
            //其他
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create];
        }
        
    } else {
        //非今年
        return create_time;
    }
}

- (BOOL)isThisYear {
    NSDate *now = [NSDate date];
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:now];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

- (BOOL)isToday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    NSString *selfStr = [formatter stringFromDate:self];
    return [nowStr isEqualToString:selfStr];
}

- (BOOL)isYesterday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
}

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}


@end
