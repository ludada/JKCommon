//
//  UIView+BlurEffect.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 2017/7/7.
//  Copyright © 2017年 people.cn. All rights reserved.
//

#import "UIView+BlurEffect.h"
#import "UIImage+Generators.h"
#import "UIImage+ImageEffects.h"

#import <objc/runtime.h>

static NSString * const JKBlurViewAssociatedKey = @"JKBlurViewAssociatedKey";

@implementation UIView (BlurEffect)

- (void)setBlurImageView:(UIImageView *)effectView {
    objc_setAssociatedObject(self, &JKBlurViewAssociatedKey, effectView, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)blurImageViewBasedOnView:(UIView *)view {
    UIImageView *effectView = (UIImageView *)objc_getAssociatedObject(self, &JKBlurViewAssociatedKey);
    if (!effectView) {
        effectView = [[UIImageView alloc] initWithFrame:self.bounds];
        effectView.contentMode = UIViewContentModeScaleToFill;
        effectView.image = [self blurImageBasedOnView:view];
        [self setBlurImageView:effectView];
    }
    return effectView;
}

- (void)blurEffectBasedOnView:(UIView *)view {
    NSAssert(![self isKindOfClass:[UIImageView class]], @"Don't call this method with a UIImageView class or it's subclass instance, use UIImage+ImageEffects APIs.");
    NSAssert(!CGSizeEqualToSize(self.bounds.size, CGSizeZero), @"View must have a frame!");
    UIImageView *imageView = [self blurImageViewBasedOnView:view];
    if (![self.subviews containsObject:imageView]) {
        imageView.frame = self.bounds;
        [self addSubview:imageView];
    }
}

#pragma mark - Image Blur Effect

- (UIImage *)blurImageBasedOnView:(UIView *)view {
    UIImage *snapshootImage = [UIImage snapshotImageFromView:view];
    return [snapshootImage applyBlurWithRadius:5.0f tintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f] saturationDeltaFactor:1.0f maskImage:nil];
}

@end
