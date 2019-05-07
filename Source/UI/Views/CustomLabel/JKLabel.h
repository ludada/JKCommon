//
//  JKLabel.h
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 2017/7/20.
//  Copyright © 2017年 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, JKTextPlaneAlignment) {
    JKTextPlaneAlignmentVerticalTop = 1,
    JKTextPlaneAlignmentVerticalCenter = 1 << 1,
    JKTextPlaneAlignmentVerticalBottom = 1 << 2,
    
    JKTextPlaneAlignmentHorizontalLeft = 1 << 3,
    JKTextPlaneAlignmentHorizontalCenter = 1 << 4,
    JKTextPlaneAlignmentHorizontalRight  = 1 << 5
};

@interface JKLabel : UILabel

@property (nonatomic, assign) CGFloat preferredLineSpacing;
@property (nonatomic, assign) UIEdgeInsets preferredEdgeInsets;
@property (nonatomic, strong) UIColor *persistentBackgroundColor;
@property (nonatomic, assign) CGFloat preferredCornerRadius;
@property (nonatomic, assign) BOOL showHalfOfHeightCornerRadius;
@property (nonatomic, assign) JKTextPlaneAlignment textPlaneAlignment;

- (void)setTextAlignment:(NSTextAlignment)textAlignment NS_UNAVAILABLE;

@end
