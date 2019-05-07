//
//  JKLabel.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 2017/7/20.
//  Copyright © 2017年 people.cn. All rights reserved.
//

#import "JKLabel.h"

@interface JKLabel ()

@end

@implementation JKLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textPlaneAlignment = JKTextPlaneAlignmentVerticalCenter | JKTextPlaneAlignmentHorizontalCenter;
    }
    return self;
}

#pragma mark - Text

- (void)setText:(NSString *)text {
    if (text == nil) {
        text = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setMaximumLineHeight:self.font.lineHeight];
    [paragraphStyle setMinimumLineHeight:self.font.lineHeight];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
        self.lineBreakMode = NSLineBreakByCharWrapping;
    }
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [paragraphStyle setLineSpacing:self.preferredLineSpacing];
    NSRange range = NSMakeRange(0, [attributedString length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:range];
    self.attributedText = attributedString;
}

- (NSString *)text {
    return [self.attributedText string];
}

#pragma mark - EdgeInsets

- (void)setPreferredEdgeInsets:(UIEdgeInsets)preferredEdgeInsets {
    _preferredEdgeInsets = preferredEdgeInsets;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.preferredEdgeInsets.left + self.preferredEdgeInsets.right;
    size.height += self.preferredEdgeInsets.top + self.preferredEdgeInsets.bottom;
    return size;
}

- (void)drawTextInRect:(CGRect)rect {
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    CGRect insetRect = UIEdgeInsetsInsetRect(rect, self.preferredEdgeInsets);
    CGRect preferredRect = [self textRectForBounds:insetRect limitedToNumberOfLines:self.numberOfLines];
    if (version < 7.0f) {
        [self.attributedText drawInRect:preferredRect];
    } else {
        [super drawTextInRect:preferredRect];
    }
}

#pragma mark - Alignment

- (void)setTextPlaneAlignment:(JKTextPlaneAlignment)textPlaneAlignment {
    _textPlaneAlignment = textPlaneAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    if (self.textPlaneAlignment & JKTextPlaneAlignmentVerticalTop) {
        textRect.origin.y = bounds.origin.y;
    }
    if (self.textPlaneAlignment & JKTextPlaneAlignmentVerticalCenter) {
        textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2;
    }
    if (self.textPlaneAlignment & JKTextPlaneAlignmentVerticalBottom) {
         textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
    }
    if (self.textPlaneAlignment & JKTextPlaneAlignmentHorizontalLeft) {
        textRect.origin.x = bounds.origin.x;
    }
    if (self.textPlaneAlignment & JKTextPlaneAlignmentHorizontalCenter) {
        textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width) / 2;
    }
    if (self.textPlaneAlignment & JKTextPlaneAlignmentHorizontalRight) {
        textRect.origin.x = bounds.origin.x + bounds.size.width - textRect.size.width;
    }
    return textRect;
}

#pragma mark - Background Color

- (void)setPersistentBackgroundColor:(UIColor *)persistentBackgroundColor {
    super.backgroundColor = persistentBackgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
}

#pragma mark - Corner Radius

- (void)setShowHalfOfHeightCornerRadius:(BOOL)showHalfOfHeightCornerRadius {
    _showHalfOfHeightCornerRadius = showHalfOfHeightCornerRadius;
}

- (void)setPreferredCornerRadius:(CGFloat)preferredCornerRadius {
    _preferredCornerRadius = preferredCornerRadius;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.showHalfOfHeightCornerRadius) {
        self.preferredCornerRadius = CGRectGetHeight(self.bounds) / 2;
    }
    self.layer.cornerRadius = self.preferredCornerRadius;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

@end
