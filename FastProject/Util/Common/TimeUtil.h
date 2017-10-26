//
//  TimeUtil.h
//  PudongC
//
//  Created by 王博 on 16/1/12.
//  Copyright © 2016年 healthbok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject

/**
 * 时间排序YYYY/MM/dd 小－大
 */
+ (NSArray *)TimeSort:(NSArray *)timeArray;
/**
 * YYYY（年）/MM（月）/dd（日） hh（时）:mm（分）:ss（秒） SS（毫秒）
 */
+ (NSString *)localTime:(NSString *)dateFormatter;
/**
 * 字符串转NSDate
 */
+(NSDate *)convertDateFromString:(NSString*)DateStr formatter:(NSString *)Forma;
/**
 * 获取当前年mm/dd
 */
+(NSString *)localTimeMMDD;

+(NSString *)localTimeFormat:(NSString *)format;

/**
 * 获取当前年YYYY
 */
+(NSString *)localTimeYear;


/**
 * 时间戳timeStampString －－> format  eg:yyyy-MM-dd  HH:mm
 */
+(NSString *)TimeStampToDate:(NSString *)timeStampString dataFormat:(NSString *)format;

/**
 * 时间戳10位－－>format  eg:yyyy-MM-dd  HH:mm
 */
+(NSString *)TimeStamp10ToDate:(NSString *)timeStampString dataFormat:(NSString *)format;
@end
