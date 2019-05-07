//
//  NSObject+Helpers.h
//  JKNews
//
//  Created by Sid on 27/03/2018.
//  Copyright © 2018 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helpers)

+ (NSDate *)nextHourFromDate:(NSDate *)date;
+ (NSDate *)nextHour;

@end
