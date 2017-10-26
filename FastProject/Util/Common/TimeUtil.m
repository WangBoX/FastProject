//
//  TimeUtil.m
//  PudongC
//
//  Created by 王博 on 16/1/12.
//  Copyright © 2016年 healthbok. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

+ (NSArray *)TimeSort:(NSArray *)timeArray
{
    timeArray = (NSMutableArray *)[timeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd/"];
        if (obj1 == [NSNull null])
        {
            obj1 = @"0000/00/00";
        }
        if (obj2 == [NSNull null])
        {
            obj2 = @"0000/00/00";
        }
        NSDate *date1 = [formatter dateFromString:obj1];
        NSDate *date2 = [formatter dateFromString:obj2];
        //小－－大
        NSComparisonResult result = [date2 compare:date1];
        return result == NSOrderedAscending;
    }];
    return timeArray;
}

+ (NSString *)localTime:(NSString *)dateFormatter{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:dateFormatter];
    NSString *dateString = [formatter stringFromDate:currentDate];
    return dateString;
}

+(NSDate *)convertDateFromString:(NSString*)DateStr formatter:(NSString *)Forma
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:Forma];
    NSDate *date=[formatter dateFromString:DateStr];
    return date;
}

+(NSString *)localTimeFormat:(NSString *)format
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //    NSLog(@"dateString:%@",dateString);
    return dateString;
}

+(NSString *)localTimeYear
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    NSLog(@"dateString:%@",dateString);
    return dateString;
}

+(NSString *)localTimeMMDD
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //YYYY（年）/MM（月）/dd（日） hh（时）:mm（分）:ss（秒） SS（毫秒）
    [dateFormatter setDateFormat:@"MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //    NSLog(@"dateString:%@",dateString);
    return dateString;
}

+(NSString *)localTime1
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //YYYY（年）/MM（月）/dd（日） hh（时）:mm（分）:ss（秒） SS（毫秒）
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //    NSLog(@"dateString:%@",dateString);
    return dateString;
}

+(NSString *)TimeStampToDate:(NSString *)timeStampString dataFormat:(NSString *)format
{
    if (timeStampString == nil) {
        return nil;
    }
   
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];

    return [objDateformat stringFromDate:date];
}

+(NSString *)TimeStamp10ToDate:(NSString *)timeStampString dataFormat:(NSString *)format
{
    if (timeStampString == nil) {
        return nil;
    }
    
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    
    return [objDateformat stringFromDate:date];
}
@end
