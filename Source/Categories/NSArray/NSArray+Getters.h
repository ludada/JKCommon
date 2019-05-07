//
//  NSArray+Getters.h
//  JKNews
//
//  Created by Sid on 21/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Getters)

- (NSArray *)mapObjectsWithBlock:(nullable id _Nullable (^)(ObjectType obj, NSUInteger idx))block;
- (nullable ObjectType)objectSafelyAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
