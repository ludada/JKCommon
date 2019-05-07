//
//  NSString+StringFormatter.h
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 25/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringFormatter)

+ (NSString *)tagString:(NSString *)string;
+ (NSString *)pictureCountWithNumber:(NSInteger)count;
+ (NSString *)commentCountWithString:(NSString *)count;
+ (NSString *)likesCountWithString:(NSString *)count;
+ (NSString *)participantCountWithString:(NSString *)count;
+ (NSString *)formattedNumberWithNumber:(NSUInteger)number;
+ (NSString *)formattedTimeWithSeconds:(NSUInteger)seconds;
+ (NSTimeInterval)secondTimestampWithString:(NSString *)string;

@end
