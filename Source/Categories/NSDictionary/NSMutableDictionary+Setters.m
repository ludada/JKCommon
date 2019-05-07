//
//  NSMutableDictionary+Setters.m
//  JKNews
//
//  Created by Sid on 23/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSMutableDictionary+Setters.h"

@implementation NSMutableDictionary (Setters)

- (void)setObjectSafely:(id)object forKey:(id)key {
    if(object && key) {
        [self setObject:object forKey:key];
    }
}

@end
