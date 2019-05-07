//
//  NSString+StringFormatter.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 25/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSString+StringFormatter.h"
#import "JKMultiLanguage.h"

@implementation NSString (StringFormatter)

+ (NSString *)tagString:(NSString *)string {
    return string.length > 2 ? [string substringToIndex:2] : string;
}

+ (NSString *)commentCountWithString:(NSString *)count {
    NSString *comments = [self formattedNumberWithNumber:[count integerValue]];
    return comments.length > 0 ? [NSString stringWithFormat:JKLocalizedString(@"news_comment_count"), comments] : @"";
}

+ (NSString *)likesCountWithString:(NSString *)count {
    NSString *likes = [self formattedNumberWithNumber:[count integerValue]];
    return likes.length > 0 ? likes : @"";
}

+ (NSString *)pictureCountWithNumber:(NSInteger)count {
    if (count <= 0) return @"";
    return [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:count]];
}

+ (NSString *)participantCountWithString:(NSString *)count {
    NSString *participants = [self formattedNumberWithNumber:[count integerValue]];
    return participants.length > 0 ? [NSString stringWithFormat:JKLocalizedString(@"news_live_participants_count"), participants] : @"";
}

+ (NSString *)formattedNumberWithNumber:(NSUInteger)number {
    if (number <= 0) return @"";
    if (number >= 100000000) return JKLocalizedString(@"news_count_over_100million");
    if (number < 1000000) return [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:number]];
    return [NSString stringWithFormat:JKLocalizedString(@"news_count_10thousand"), [NSNumber numberWithInteger:number / 10000]];
}

+ (NSString *)formattedTimeWithSeconds:(NSUInteger)seconds {
    if (seconds <= 0) return @"00:00";
    if (seconds >= 99 * 60 * 60 + 59 * 60 + 59) return @"99:59:59";
    NSInteger second = seconds % 60;
    NSInteger minute = seconds / 60 % 60;
    NSInteger hour = seconds / 60 / 60;
    if (hour == 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minute, (long)second];
    }
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hour, (long)minute, (long)second];
}

+ (NSTimeInterval)secondTimestampWithString:(NSString *)string {
    if (string.length >= 10) {
        return [[string substringToIndex:10] doubleValue];
    }
    return [string doubleValue];
}

@end
