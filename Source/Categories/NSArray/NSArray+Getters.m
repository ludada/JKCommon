//
//  NSArray+Getters.m
//  JKNews
//
//  Created by Sid on 21/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSArray+Getters.h"

@implementation NSArray (Getters)

- (NSArray *)mapObjectsWithBlock:(id  _Nullable (^)(id _Nonnull, NSUInteger))block {
    NSMutableArray *arr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id object = block(obj, idx);
        if (object) {
            [arr addObject:object];
        }
    }];
    return arr;
}

- (id)objectSafelyAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end
