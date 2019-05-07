//
//  JKSegmentedControl.m
//  JKNews
//
//  Created by Sid on 06/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "JKSegmentedControl.h"

@interface JKSegmentedControl ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIView *borderView;

@end

@implementation JKSegmentedControl

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.maskLayer) {
        self.maskLayer = nil;
    }
    if (!self.borderView.superview) {
        [self addSubview:self.borderView];
    }
    self.borderView.frame = self.bounds;
    self.borderView.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    self.borderView.layer.borderColor = self.tintColor.CGColor;
    self.layer.mask = self.maskLayer;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.frame = self.bounds;
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        CGFloat radius = height / 2;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(radius, 0)];
        [path addLineToPoint:CGPointMake(radius, 0)];
        [path addArcWithCenter:CGPointMake(width - radius, radius) radius:height/2 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
        [path addLineToPoint:CGPointMake(radius, height)];
        [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI_2 endAngle:M_PI_2 + M_PI clockwise:YES];
        [path setLineWidth:[UIScreen mainScreen].scale];
        _maskLayer.path = path.CGPath;
    }
    return _maskLayer;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [[UIView alloc] initWithFrame:CGRectZero];
        _borderView.userInteractionEnabled = NO;
        _borderView.backgroundColor = [UIColor clearColor];
        _borderView.layer.borderColor = [UIColor whiteColor].CGColor;
        _borderView.layer.borderWidth = 1.2;
    }
    return _borderView;
}

@end
