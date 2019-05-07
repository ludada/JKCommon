//
//  NSMutableDictionary+Setters.h
//  JKNews
//
//  Created by Sid on 23/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary<KeyType, ObjectType> (Setters)

- (void)setObjectSafely:(nullable ObjectType)object forKey:(nullable KeyType)key;

@end
