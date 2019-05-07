//
//  UIView+EmptyOverlay.m
//  JKNews
//
//  Created by Sid on 27/03/2018.
//  Copyright © 2018 people.cn. All rights reserved.
//

#import "UIView+EmptyOverlay.h"
#import <Masonry/Masonry.h>
#import "UIButton+Block.h"
#import "JKMacros.h"
#import "JKMultiLanguage.h"
#import "UIColor+Generators.h"

@implementation UIView (EmptyOverlay)

JKSYNTH_DYNAMIC_PROPERTY_OBJECT(emptyOverlay, setEmptyOverlay, RETAIN, UIView *)
JKSYNTH_DYNAMIC_PROPERTY_OBJECT(emptyOverlayButton, setEmptyOverlayButton, RETAIN, UIButton *)
JKSYNTH_DYNAMIC_PROPERTY_OBJECT(emptyOverlayImageView, setEmptyOverlayImageView, RETAIN, UIImageView *)
JKSYNTH_DYNAMIC_PROPERTY_OBJECT(emptyOverlayLabel, setEmptyOverlayLabel, RETAIN, UILabel *)
JKSYNTH_DYNAMIC_PROPERTY_CTYPE(emptyOverlayType, setEmptyOverlayType, JKEmptyOverlayType)


- (void)showEmptyOverlay:(BOOL)show tapActionBlock:(void(^)(void))tapActionBlock{
    [self showEmptyOverlay:show type:JKEmptyOverlayTypeDefault tapActionBlock:tapActionBlock];
}

- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type tapActionBlock:(void (^)(void))tapActionBlock {
    [self showEmptyOverlay:show type:type animated:NO tapActionBlock:tapActionBlock];
}

- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type animated:(BOOL)animated tapActionBlock:(void (^)(void))tapActionBlock {
    [self showEmptyOverlay:show type:type edgeInsets:UIEdgeInsetsZero animated:animated tapActionBlock:tapActionBlock];
}

- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type edgeInsets:(UIEdgeInsets)edgeInsets tapActionBlock:(void (^)(void))tapActionBlock {
    [self showEmptyOverlay:show type:type edgeInsets:edgeInsets animated:NO tapActionBlock:tapActionBlock];
}

- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type constraintView:(UIView *)view tapActionBlock:(void(^)(void))tapActionBlock {
    if (!self.emptyOverlay || self.emptyOverlayType != type) {
        [self.emptyOverlay removeFromSuperview];
        self.emptyOverlay = [self generateEmptyOverlay:type];
    }
    [self configureWithType:type];
    CGFloat fromAlpha = show ? 0 : 1;
    CGFloat toAlpha = 1 - fromAlpha;
    CGFloat duration = 0;
    self.emptyOverlay.alpha = fromAlpha;
    
    if (!self.emptyOverlay.superview) {
        [self addSubview:self.emptyOverlay];
        [self.emptyOverlay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(view);
        }];
    }
    [self.emptyOverlayButton addActionBlock:^(UIButton *button) {
        if (tapActionBlock) {
            tapActionBlock();
        }
    }];
    [UIView animateWithDuration:duration
                     animations:^{
                         self.emptyOverlay.alpha = toAlpha;
                     } completion:^(BOOL finished) {
                         self.emptyOverlay.hidden = !show;
                     }];
}

- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type edgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated tapActionBlock:(void(^)(void))tapActionBlock {
    if (!self.emptyOverlay || self.emptyOverlayType != type) {
        [self.emptyOverlay removeFromSuperview];
        self.emptyOverlay = [self generateEmptyOverlay:type];
    }
    [self configureWithType:type];
    CGFloat fromAlpha = show ? 0 : 1;
    CGFloat toAlpha = 1 - fromAlpha;
    CGFloat duration = animated ? 0.3 : 0;
    self.emptyOverlay.alpha = fromAlpha;
    
    [self configureEmptyOverlayWithEdgeInsets:edgeInsets tapActionBlock:tapActionBlock];
    [UIView animateWithDuration:duration
                     animations:^{
                         self.emptyOverlay.alpha = toAlpha;
                     } completion:^(BOOL finished) {
                         self.emptyOverlay.hidden = !show;
                     }];
}

- (void)configureEmptyOverlayWithEdgeInsets:(UIEdgeInsets)edgeInsets tapActionBlock:(void(^)(void))tapActionBlock {
    if (!self.emptyOverlay.superview) {
        [self addSubview:self.emptyOverlay];
        [self.emptyOverlay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(edgeInsets);
        }];
    } else {
        [self.emptyOverlay mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(edgeInsets);
        }];
    }
    [self.emptyOverlayButton addActionBlock:^(UIButton *button) {
        if (tapActionBlock) {
            tapActionBlock();
        }
    }];
}

- (UIView *)generateEmptyOverlay:(JKEmptyOverlayType)type {
    self.emptyOverlayType = type;
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = type == JKEmptyOverlayTypeImageSet || type == JKEmptyOverlayTypeImageSetRetry ? [UIColor blackColor] : [UIColor whiteColor];
    
    UIView *contentView = [self generateContentView:type];
    [view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY).with.offset(-40);
    }];
    
    self.emptyOverlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [view addSubview:self.emptyOverlayButton];
    [self.emptyOverlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    return view;
}

- (UIView *)generateContentView:(JKEmptyOverlayType)type {
    UIView *view = [UIView new];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeCenter;
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
    }];
    self.emptyOverlayImageView = imageView;
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRGBHex:0x9b9b9b alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(34);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.emptyOverlayLabel = label;
    
    [self configureWithType:type];
    
    return view;
}

- (void)configureWithType:(JKEmptyOverlayType)type {
    NSString *imageName;
    NSString *text;
    if (type == JKEmptyOverlayTypeFavorite) {
        imageName = @"empty_view_overlay_news";
        text = JKLocalizedString(@"hint_no_favorite");
    } else if (type == JKEmptyOverlayTypeNews) {
        imageName = @"empty_view_overlay_news";
        text = JKLocalizedString(@"hint_no_news");
    } else if (type == JKEmptyOverlayTypeImageSet) {
        imageName = @"empty_view_overlay_news";
        text = JKLocalizedString(@"hint_image_set_empty");
    } else if (type == JKEmptyOverlayTypeComment) {
        imageName = @"empty_view_overlay_news";
        text = JKLocalizedString(@"hint_no_comment");
    } else if (type == JKEmptyOverlayTypeSearch) {
        imageName = @"empty_view_overlay_news";
        text = JKLocalizedString(@"hint_no_search_results");
    } else if (type == JKEmptyOverlayTypeCPN) {
        imageName = @"empty_view_overlay_cpn";
        text = JKLocalizedString(@"hint_no_data_resule");
    } else {
        imageName = @"empty_view_overlay";
        text = JKLocalizedString(@"hint_no_content");
    }
    self.emptyOverlayImageView.image = [UIImage imageNamed:imageName];
    self.emptyOverlayLabel.text = text;
}

@end
