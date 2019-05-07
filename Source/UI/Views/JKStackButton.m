//
//  JKStackButton.m
//  JKNews
//
//  Created by Sid on 24/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "JKStackButton.h"
#import "JKMacros.h"
#import "UIColor+Generators.h"
#import <Masonry/Masonry.h>
#import "MAKVONotificationCenter.h"

@implementation JKStackButton

- (void)dealloc {
    [self.button removeObserver:self keyPath:KeyPath(self.button.highlighted)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews {
    [self configureImageView];
    [self configureTitleLabel];
    [self configureButton];
}

- (void)configureImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)configureTitleLabel {
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor colorWithRGBHex:0x757575 alpha:1];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).with.offset(11);
        make.height.mas_equalTo(12);
        make.left.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(56);
    }];
}

- (void)configureButton {
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(44);
        make.left.mas_greaterThanOrEqualTo(0);
        make.right.mas_lessThanOrEqualTo(0);
        make.top.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    __weak typeof(self) weakSelf = self;
    [self.button addObserver:self keyPath:KeyPath(self.button.highlighted) options:kNilOptions block:^(MAKVONotification *notification) {
        if (weakSelf.button.isHighlighted) {
            [weakSelf prepareImageViewForBounce];
        } else {
            [weakSelf bounceImageView];
        }
    }];
    [self.button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareImageViewForBounce {
    [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:nil];
}

- (void)bounceImageView {
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (UIImageView *)imageView {
    return _imageView ?: (_imageView = [UIImageView new]);
}

- (UILabel *)titleLabel {
    return _titleLabel ?: (_titleLabel = [UILabel new]);
}

- (UIButton *)button {
    return _button ?: (_button = [UIButton buttonWithType:UIButtonTypeCustom]);
}

- (void)onButtonPressed:(UIButton *)sender {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}

@end
