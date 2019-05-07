//
//  UIView+GradientMask.h
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 13/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GradientMask)

+ (UIView *)viewForGradientMaskStartAtPoint:(CGPoint)startPoint fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor endAtPoint:(CGPoint)endPoint;

/**
 *  设置部分圆角
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners Radii:(CGSize)radii andRect:(CGRect)rect;
@end
