//
//  JKActionSheetButton.m
//  JKNews
//
//  Created by Sid on 24/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "JKActionSheetButton.h"
#import "JKMultiLanguage.h"
#import "UIImage+Generators.h"

@interface JKActionSheetButton ()

@property (nonatomic, readwrite) JKActionSheetButtonType type;

@end

@implementation JKActionSheetButton

+ (instancetype)buttonWithType:(JKActionSheetButtonType)type {
    JKActionSheetButton *button = [[self alloc] initWithFrame:CGRectZero];
    [button configureWithType:type];
    return button;
}

- (void)configureWithType:(JKActionSheetButtonType)type {
    self.type = type;
    self.titleLabel.text = [self titleWithType:type];
    self.enabled = YES;
    if (self.type == JKActionSheetButtonTypeFavorite) {
        self.imageView.highlightedImage = [UIImage imageNamed:@"icon_action_sheet_favorite_selected"];
    }
}

- (void)onButtonPressed:(UIButton *)sender {
    [super onButtonPressed:sender];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectActionSheetButton:)]) {
        [self.delegate didSelectActionSheetButton:self];
    }
}

- (void)setEnabled:(BOOL)enabled {
    if (_enabled != enabled) {
        _enabled = enabled;
        UIImage *image = [self imageWithType:self.type];
        self.imageView.image = enabled ? image : [image grayscaleImage];
        self.userInteractionEnabled = enabled;
    }
}

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        _selected = selected;
        if (self.type == JKActionSheetButtonTypeFavorite) {
            self.imageView.highlighted = selected;
            self.titleLabel.text = selected ? JKLocalizedString(@"button_title_unfavorite") : [self titleWithType:JKActionSheetButtonTypeFavorite];
        }
    }
}

- (UIImage *)imageWithType:(JKActionSheetButtonType)type {
    NSString *imageName = @"";
    switch (type) {
        case JKActionSheetButtonTypeWechat:
            imageName = @"btn_wechat";
            break;
        case JKActionSheetButtonTypeMoments:
            imageName = @"btn_wechat_moments";
            break;
        case JKActionSheetButtonTypeWeibo:
            imageName = @"btn_weibo";
            break;
        case JKActionSheetButtonTypeQQ:
            imageName = @"btn_qq";
            break;
        case JKActionSheetButtonTypeQzone:
            imageName = @"btn_qzone";
            break;
        case JKActionSheetButtonTypeLink:
            imageName = @"btn_link";
            break;
        case JKActionSheetButtonTypeFavorite:
            imageName = @"icon_action_sheet_favorite_normal";
            break;
        case JKActionSheetButtonTypeFont:
            imageName = @"btn_font_size";
            break;
        case JKActionSheetButtonTypeDownload:
            imageName = @"btn_more_download";
            break;
        case JKActionSheetButtonTypeSafari:
            imageName = @"button_more_safari";
            break;
        case JKActionSheetButtonTypeRefresh:
            imageName = @"button_more_ refresh";
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (NSString *)titleWithType:(JKActionSheetButtonType)type {
    NSString *title = @"";
    switch (type) {
        case JKActionSheetButtonTypeWechat:
            title = JKLocalizedString(@"social_wechat_title");
            break;
        case JKActionSheetButtonTypeMoments:
            title = JKLocalizedString(@"social_wechat_moments_title");
            break;
        case JKActionSheetButtonTypeWeibo:
            title = JKLocalizedString(@"social_weibo_title");
            break;
        case JKActionSheetButtonTypeQQ:
            title = JKLocalizedString(@"social_qq_title");
            break;
        case JKActionSheetButtonTypeQzone:
            title = JKLocalizedString(@"social_qzone_title");
            break;
        case JKActionSheetButtonTypeLink:
            title = JKLocalizedString(@"social_link_title");
            break;
        case JKActionSheetButtonTypeFavorite:
            title = JKLocalizedString(@"button_title_favorite");
            break;
        case JKActionSheetButtonTypeFont:
            title = JKLocalizedString(@"text_font_size");
            break;
        case JKActionSheetButtonTypeDownload:
            title = JKLocalizedString(@"button_title_download");
            break;
        case JKActionSheetButtonTypeSafari:
            title = JKLocalizedString(@"social_open_via_safari");
            break;
        case JKActionSheetButtonTypeRefresh:
            title = JKLocalizedString(@"social_refresh_current_page");
            break;
    }
    return title;
}

@end
