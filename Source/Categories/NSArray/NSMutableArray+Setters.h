//
//  NSMutableArray+Setters.h
//  JKNews
//
//  Created by Sid on 27/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray<ObjectType> (Setters)

- (void)addObjectSafely:(nullable ObjectType)object;

@end
