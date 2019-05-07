//
//  NSObject+Helpers.m
//  JKNews
//
//  Created by Sid on 27/03/2018.
//  Copyright © 2018 people.cn. All rights reserved.
//

#import "NSDate+Helpers.h"

@implementation NSDate (Helpers)

+ (NSDate *)nextHourFromDate:(NSDate *)date {
    NSDate *d = [NSDate dateWithTimeInterval:3600 sinceDate:date];
    NSTimeInterval timestamp = [d timeIntervalSince1970];
    NSUInteger roundedT = [@(timestamp) unsignedLongValue];
    roundedT -= (roundedT % 3600);
    return [NSDate dateWithTimeIntervalSince1970:roundedT];
}

+ (NSDate *)nextHour {
    return [self nextHourFromDate:[NSDate date]];
}

@end
