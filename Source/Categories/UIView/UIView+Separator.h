//
//  UIView+Separator.h
//  JKNews
//
//  Created by Sid on 29/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, JKSeparatorPositions) {
    JKSeparatorPositionsTop = 1,
    JKSeparatorPositionsBottom = 1 << 1,
    JKSeparatorPositionsLeft = 1 << 2,
    JKSeparatorPositionsRight = 1 << 3
};

@interface UIView (Separator)

- (void)addOnePixelSeparator:(JKSeparatorPositions)positions color:(UIColor *)color;
- (void)addOnePixelSeparator:(JKSeparatorPositions)positions color:(UIColor *)color offset:(CGFloat)offset;
- (void)addOnePixelSeparator:(JKSeparatorPositions)positions color:(UIColor *)color offset:(CGFloat)offset lineWidth:(CGFloat)lineWidth;

@end
