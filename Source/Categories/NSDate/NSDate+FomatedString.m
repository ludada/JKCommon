//
//  NSDate+FomatedString.m
//  JKNews
//
//  Created by Sid on 10/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSDate+FomatedString.h"
#import "JKMultiLanguage.h"

@implementation NSDate (FomatedString)

+ (NSTimeZone *)baseTimeZone {
    return [NSTimeZone timeZoneForSecondsFromGMT:28800];
}

+ (NSTimeInterval)secondOfToday:(NSDate *)date isPast:(BOOL)isPast {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [self baseTimeZone];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    NSTimeInterval pastSecond = dateComponents.hour * 60 * 60 + dateComponents.minute * 60 + dateComponents.second;
    NSTimeInterval second = isPast ? pastSecond : 24 * 60 * 60 - pastSecond;
    return second;
}

+ (BOOL)isToday:(NSTimeInterval)time date:(NSDate *)date isPast:(BOOL)isPast {
    return time <= [self secondOfToday:date isPast:isPast];
}

+ (BOOL)isTomorrow:(NSTimeInterval)time date:(NSDate *)date {
    NSTimeInterval remainedSecondOfToday = [self secondOfToday:date isPast:NO];
    return time > remainedSecondOfToday && time < 24 * 60 * 60 + remainedSecondOfToday;
}

+ (BOOL)isYesterday:(NSTimeInterval)time date:(NSDate *)date {
    return time > [self secondOfToday:date isPast:YES] && time < ([self secondOfToday:date isPast:YES] + 24 * 60 * 60);
}

+ (BOOL)isPastTimeOfThisYear:(NSTimeInterval)time date:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [self baseTimeZone];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:date];
    dateComponents.month = 1;
    dateComponents.day = 1;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    NSDate *firstDay = [calendar dateFromComponents:dateComponents];
    NSTimeInterval second = [date timeIntervalSinceDate:firstDay];
    return time <= second;
}

+ (BOOL)isRemainedTimeOfThisYead:(NSTimeInterval)time date:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [self baseTimeZone];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:date];
    dateComponents.month = 12;
    dateComponents.day = 31;
    dateComponents.hour = 23;
    dateComponents.minute = 59;
    dateComponents.second = 59;
    NSDate *lastDay = [calendar dateFromComponents:dateComponents];
    NSTimeInterval second = [lastDay timeIntervalSinceDate:date];
    return time <= second;
}

+ (NSString *)formatedRelativeTimeStringWithTimestamp:(NSTimeInterval)timestamp {
    if (timestamp <= 0) {
        return @"";
    }
    return [self formatedRelativeTimeStringWithTimestamp:timestamp relativeDate:[NSDate date]];
}

+ (NSString *)formatedRelativeTimeStringWithTimestamp:(NSTimeInterval)timestamp relativeDate:(NSDate *)relativeDate {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSInteger second = [relativeDate timeIntervalSinceDate:date];
    
    if (second < 0) {
        if ([self isToday:-second date:relativeDate isPast:NO]) {
            return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_future_relative_time_within_today")];
        }
        if ([self isTomorrow:-second date:relativeDate]) {
            return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_future_relative_time_within_tomorrow")];
        }
        if ([self isRemainedTimeOfThisYead:-second date:date]) {
            return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_future_relative_time_within_this_year")];
        }
        return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_date_format_full")];
    }
    
//    if (second == 0) {
//        return JKLocalizedString(@"formated_relative_time_now");
//    }
    if (second < 60 * 60) {
        return [NSString stringWithFormat:JKLocalizedString(@"formated_past_relative_time_within_60m"), @(MAX(1, second / 60))];
    }
    if ([self isToday:second date:relativeDate isPast:YES]) {
        return [NSString stringWithFormat:JKLocalizedString(@"formated_past_relative_time_within_today"), @(second / 3600)];
    }
    if ([self isYesterday:second date:relativeDate]) {
        return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_past_relative_time_within_yesterday")];
    }
    if ([self isPastTimeOfThisYear:second date:date]) {
        return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_past_relative_time_within_this_year")];
    }
    return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_date_format_full")];
}

+ (NSString *)formatedDateStringWithTimestamp:(NSTimeInterval)timestamp stringFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    dateFormatter.timeZone = [self baseTimeZone];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)fullDateString:(NSTimeInterval)timestamp {
    if (timestamp <= 0) {
        return @"";
    }
    return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_date_format_full")];
}

+ (NSString *)shortDateString:(NSTimeInterval)timestamp {
    if (timestamp <= 0) {
        return @"";
    }
    return [self formatedDateStringWithTimestamp:timestamp stringFormat:JKLocalizedString(@"formated_date_format_short")];
}

+ (NSTimeInterval)timestampWithMilliseconds:(NSNumber *)milliseconds {
    uint64_t time = milliseconds.unsignedLongLongValue / 1000;
    return time;
}

+ (NSNumber *)millisecondsWithTimestamp:(NSTimeInterval)timestamp {
    return @(lrint(timestamp * 1000));
}

+ (NSString *)formatedCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    formatter.timeZone = [self baseTimeZone];
    formatter.dateFormat = JKLocalizedString(@"formated_date_current_date");
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSDate *)dateWithISO8601String:(NSString *)string {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (NSDate *)dateWithPrecisionISO8601String:(NSString *)string {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    return dateFormatter;
}

+ (NSString *)ISO8601StringWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}

+ (NSString *)ISO8601StringWithTimestamp:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [self ISO8601StringWithDate:date];
}

+ (NSString *)precisionISO8601StringWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}

+ (NSString *)precisionISO8601StringWithTimestamp:(NSTimeInterval)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [self precisionISO8601StringWithDate:date];
}

@end
