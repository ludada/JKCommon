//
//  JKAttributedLabel.h
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 14/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKAttributedRange : NSObject

@property (nonatomic, assign, readonly) NSRange range;
@property (nonatomic, strong, readonly) UIFont *font;
@property (nonatomic, strong, readonly) UIColor *textColor;
@property (nonatomic, strong, readonly) UIColor *highlightedColor;

+ (instancetype)rangeWithRange:(NSRange)range font:(UIFont *)font textColor:(UIColor *)textColor;
- (instancetype)init NS_UNAVAILABLE;

@end

@interface JKAttributedLabel : UILabel

@property (nonatomic, assign) BOOL enableHighlightedEffect;

- (void)addText:(NSString *)text attributedRanges:(NSArray<JKAttributedRange *> *)attributedRanges eventHandler:(void (^ _Nullable)(NSString *string, NSRange range, NSUInteger index))eventHandler;

@end

NS_ASSUME_NONNULL_END
