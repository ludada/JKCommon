//
//  NSDate+FomatedString.h
//  JKNews
//
//  Created by Sid on 10/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FomatedString)

+ (NSString *)formatedRelativeTimeStringWithTimestamp:(NSTimeInterval)timestamp;
+ (NSString *)fullDateString:(NSTimeInterval)timestamp;
+ (NSString *)shortDateString:(NSTimeInterval)timestamp;

+ (NSTimeInterval)timestampWithMilliseconds:(NSNumber *)milliseconds;
+ (NSNumber *)millisecondsWithTimestamp:(NSTimeInterval)timestamp;

+ (NSString *)formatedCurrentDate;

+ (NSDate *)dateWithISO8601String:(NSString *)string;
+ (NSDate *)dateWithPrecisionISO8601String:(NSString *)string;

+ (NSString *)ISO8601StringWithDate:(NSDate *)date;
+ (NSString *)ISO8601StringWithTimestamp:(NSTimeInterval)timestamp;
+ (NSString *)precisionISO8601StringWithDate:(NSDate *)date;
+ (NSString *)precisionISO8601StringWithTimestamp:(NSTimeInterval)timestamp;

@end
