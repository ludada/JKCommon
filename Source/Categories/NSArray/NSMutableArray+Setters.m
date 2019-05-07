//
//  NSMutableArray+Setters.m
//  JKNews
//
//  Created by Sid on 27/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSMutableArray+Setters.h"

@implementation NSMutableArray (Setters)

- (void)addObjectSafely:(id)object {
    if (object) {
        [self addObject:object];
    }
}

@end
