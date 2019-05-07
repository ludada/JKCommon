//
//  UIView+GradientMask.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 13/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+GradientMask.h"

@implementation UIView (GradientMask)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

+ (UIView *)viewForGradientMaskStartAtPoint:(CGPoint)startPoint fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor endAtPoint:(CGPoint)endPoint {
    UIView *view = [[self alloc] init];
    CAGradientLayer *layer = (CAGradientLayer *)view.layer;
    layer.colors = @[(id)fromColor.CGColor, (id)toColor.CGColor];
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    return view;
}

- (void)addRoundedCorners:(UIRectCorner)corners Radii:(CGSize)radii andRect:(CGRect)rect {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}
@end
