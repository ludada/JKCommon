//
//  NSDictionary+Getters.m
//  JKNews
//
//  Created by Sid on 23/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSDictionary+Getters.h"
#import "NSMutableDictionary+Setters.h"

@implementation NSDictionary (Getters)

- (NSArray *)arrayForKeySafely:(id)key {
    id array = [self objectForKey:key];
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }
    return nil;
}

- (NSDictionary *)dictionaryForKeySafely:(id)key {
    id dictionary = [self objectForKey:key];
    if([dictionary isKindOfClass:[NSDictionary class]])
    return dictionary;
    return nil;
    
}

- (NSString *)stringForKeySafely:(id)key {
    id string = [self objectForKey:key];
    if([string isKindOfClass:[NSString class]])
    return string;
    if([string isKindOfClass:[NSNumber class]])
    return [NSString stringWithFormat:@"%@", string];
    return nil;
}

- (NSNumber *)numberForKeySafely:(id)key {
    id number = [self objectForKey:key];
    if([number isKindOfClass:[NSNumber class]])
    return number;
    if([number isKindOfClass:[NSString class]])
    return [self numberFromString:(NSString*)number];
    return nil;
}

- (NSNumber*)numberFromString:(NSString*)string {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

- (BOOL)boolForKeySafely:(id)key withDefaultValue:(BOOL)defaultValue {
    id boolean = [self objectForKey:key];
    if([boolean isKindOfClass:[NSNumber class]])
    return [boolean boolValue];
    if([boolean isKindOfClass:[NSString class]]) {
        if([boolean isEqual:@"true"]) return YES;
        if([boolean isEqual:@"false"]) return NO;
    }
    return defaultValue;
}

- (NSDate *)dateForKeySafely:(id)key {
    id date = [self objectForKey:key];
    if([date isKindOfClass:[NSDate class]])
    return date;
    return nil;
}

- (NSDictionary *)dictionaryBySettingObject:(id)object forKey:(id)key {
    NSMutableDictionary *dictionary = [self mutableCopy];
    [dictionary setObjectSafely:object forKey:key];
    return dictionary;
}


@end
