//
//  UIColor+Generators.m
//  JKNews
//
//  Created by Sid on 21/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIColor+Generators.h"

#define ARC4RANDOM_MAX      0x100000000
#define RANDOM_DOUBLE ((double)arc4random() / ARC4RANDOM_MAX)
#define RANDOM_DOUBLE_BETWEEN(x, y) (x + ((y - x) * RANDOM_DOUBLE))

@implementation UIColor (Generators)

- (UIColor *)colorWithBrightness:(CGFloat)brightness {
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        return [self.class colorWithHue:h saturation:s brightness:MIN(MAX(brightness, 0.0), 1.0) alpha:a];
    }
    return nil; // Couldn't calculate new brightness.
}

+ (UIColor *)colorWithR:(int)red G:(int)green B:(int)blue A:(CGFloat)alpha {
    NSAssert(0 <= red && red <= 255, @"int (red) must be between 0 and 255 (inclusive)");
    NSAssert(0 <= green && green <= 255, @"int (green) must be between 0 and 255 (inclusive)");
    NSAssert(0 <= blue && blue <= 255, @"int (blue) must be between 0 and 255 (inclusive)");
    return [self colorWithRed:red / 255.f green:green / 255.f blue:blue / 255.f alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(int)hexColor alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(((hexColor >> 16) & 0xFF)) / 255.0f
                           green:(((hexColor >> 8) & 0xFF)) / 255.0f
                            blue:((hexColor & 0xFF)) / 255.0f
                           alpha:alpha];
}

+ (UIColor *)randomColor {
    return [self colorWithRed:RANDOM_DOUBLE_BETWEEN(0, 1) green:RANDOM_DOUBLE_BETWEEN(0, 1) blue:RANDOM_DOUBLE_BETWEEN(0, 1) alpha:1];
}


@end
