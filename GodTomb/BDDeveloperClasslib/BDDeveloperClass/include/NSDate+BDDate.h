//
//  NSDate+BDDate.h
//  BDDeveloperClass
//
//  Created by TTgg on 16/3/23.
//  Copyright © 2016年 TTgg. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    bd_compareTime_less    = -1,
    bd_compareTime_equal   = 0,
    bd_compareTime_greater = 1
}bd_compareTime;
@interface NSDate (BDDate)
/*
 对比两个时间t1，t2先后，
 返回时间早晚
 bd_compareTime_less:    t1早
 bd_compareTime_equal:   t1=t2
 bd_compareTime_greater: t1晚
 */
+(bd_compareTime)bd_compareFirstDate:(NSDate *)t1 secondDate:(NSDate *)t2;
/*
 返回两个时间t1，t2时间差
 返回字典:d-天数，h-小时，m-分钟，s-秒钟
 */
+(NSDictionary *)bd_extractFirstDate:(NSDate *)date1  secondDate:(NSDate *)date2;
/*
 根据formate，返回相应字符串
 */
+(NSString *)bd_returnTimeWithFormatter:(NSString *)formaterstr withDate:(NSDate *)date;

/*
 根据formate，把string转为nsdate
 */
+(NSDate *)bd_exchangeStringToDate:(NSString *)dateStr withFormatter:(NSString *)formatterStr;
/*
 返回时间轴文字，大前天，前天，昨天，今天，明天，后天,大后天
 相比于给定时间，（如果没有，就手机当前时间）
 @[@{}……]
 c:中文，t:时间，s:坐标轴位置（-3——3）
 */
+(NSArray *)bd_timeShaftForString:(NSDate *)date withFormatter:(NSString *)formatter;
/*
 返回星期时间
 for:星期五
 */
+(NSString *)bd_returnWeekDay:(id)date withFormatter:(NSString *)formatterStr;
/*
 返回农历
 for:丁酉_正月_十四
 */
+(NSString *)bd_returnLunarCalendar:(id)date withFormatter:(NSString *)formatterStr;
@end
