//
//  NSDictionary+Getters.h
//  JKNews
//
//  Created by Sid on 23/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (Getters)

- (nullable NSArray*)arrayForKeySafely:(nullable KeyType)key;
- (nullable NSDictionary*)dictionaryForKeySafely:(nullable KeyType)key;
- (nullable NSString*)stringForKeySafely:(nullable KeyType)key;
- (nullable NSNumber*)numberForKeySafely:(nullable KeyType)key;
- (BOOL)boolForKeySafely:(KeyType)key withDefaultValue:(BOOL)defaultValue;
- (nullable NSDate*)dateForKeySafely:(nullable KeyType)key;
- (NSDictionary<KeyType, ObjectType>*)dictionaryBySettingObject:(ObjectType)object forKey:(KeyType)key;

@end

NS_ASSUME_NONNULL_END
