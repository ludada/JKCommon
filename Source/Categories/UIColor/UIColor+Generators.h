//
//  UIColor+Generators.h
//  JKNews
//
//  Created by Sid on 21/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Generators)

- (UIColor *)colorWithBrightness:(CGFloat)brightness;
+ (UIColor *)colorWithR:(int)red G:(int)green B:(int)blue A:(CGFloat)alpha;
+ (UIColor *)colorWithRGBHex:(int)hexColor alpha:(CGFloat)alpha;
+ (UIColor *)randomColor;

@end
