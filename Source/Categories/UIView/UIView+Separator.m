//
//  UIView+Separator.m
//  JKNews
//
//  Created by Sid on 29/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+Separator.h"
#import <Masonry/Masonry.h>
#import "UIImage+Generators.h"

@implementation UIView (Separator)

- (void)addOnePixelSeparator:(JKSeparatorPositions)positions color:(UIColor *)color offset:(CGFloat)offset lineWidth:(CGFloat)lineWidth {
    UIImage *image = [UIImage resizableImageWithColor:color];
    if (positions & JKSeparatorPositionsTop) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = imageView.highlightedImage = image;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(offset);
            make.right.mas_equalTo(-offset);
            make.height.mas_equalTo(lineWidth);
        }];
    }
    if (positions & JKSeparatorPositionsBottom) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = imageView.highlightedImage = image;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(offset);
            make.right.mas_equalTo(-offset);
            make.height.mas_equalTo(lineWidth);
        }];
    }
    if (positions & JKSeparatorPositionsLeft) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = imageView.highlightedImage = image;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(offset);
            make.bottom.mas_equalTo(-offset);
            make.width.mas_equalTo(lineWidth);
        }];
    }
    if (positions & JKSeparatorPositionsRight) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = imageView.highlightedImage = image;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(offset);
            make.bottom.mas_equalTo(-offset);
            make.width.mas_equalTo(lineWidth);
        }];
    }
}

- (void)addOnePixelSeparator:(JKSeparatorPositions)positions color:(UIColor *)color {
    [self addOnePixelSeparator:positions color:color offset:0 lineWidth:1.0f / [UIScreen mainScreen].scale];
}

- (void)addOnePixelSeparator:(JKSeparatorPositions)positions color:(UIColor *)color offset:(CGFloat)offset {
    [self addOnePixelSeparator:positions color:color offset:offset lineWidth:1.0f / [UIScreen mainScreen].scale];
}

@end
