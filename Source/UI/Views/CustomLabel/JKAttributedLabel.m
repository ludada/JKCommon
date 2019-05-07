//
//  JKAttributedLabel.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 14/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "JKAttributedLabel.h"

@interface JKAttributedRange ()

@end

@implementation JKAttributedRange

@synthesize range = _range, font = _font, textColor = _textColor;

+ (instancetype)rangeWithRange:(NSRange)range font:(UIFont *)font textColor:(UIColor *)textColor {
    return [[self alloc] initWithRange:range font:font textColor:textColor];
}

- (instancetype)initWithRange:(NSRange)range font:(UIFont *)font textColor:(UIColor *)textColor {
    if (self = [super init]) {
        _range = range;
        _font = font;
        _textColor = textColor;
    }
    return self;
}

#pragma Getters

- (NSRange)range {
    return _range;
}

- (UIFont *)font {
    return _font;
}

- (UIColor *)textColor {
    return _textColor;
}

@end

@interface JKAttributedLabel ()

@end

@implementation JKAttributedLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.enableHighlightedEffect = YES;
    }
    return self;
}

- (void)addText:(NSString *)text attributedRanges:(NSArray<JKAttributedRange *> *)attributedRanges eventHandler:(void (^ _Nullable)(NSString *string, NSRange range, NSUInteger index))eventHandler {
    if (!text || text.length == 0) return;
    __block NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    if (attributedRanges && attributedRanges.count > 0) {
        [attributedRanges enumerateObjectsUsingBlock:^(JKAttributedRange * _Nonnull attributedRange, NSUInteger index, BOOL * _Nonnull stop) {
            // NSRange range = [text rangeOfString:attributedRange.text];
            if (attributedRange.range.location != NSNotFound) {
                [attributedText addAttributes:@{NSFontAttributeName: attributedRange.font, NSForegroundColorAttributeName: attributedRange.textColor} range:attributedRange.range];
            }
        }];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4.0f];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return [super hitTest:point withEvent:event];
//}

@end
