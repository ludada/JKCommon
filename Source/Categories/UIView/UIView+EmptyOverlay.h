//
//  UIView+EmptyOverlay.h
//  JKNews
//
//  Created by Sid on 27/03/2018.
//  Copyright © 2018 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JKEmptyOverlayType) {
    JKEmptyOverlayTypeDefault = 0,
    JKEmptyOverlayTypeFavorite,
    JKEmptyOverlayTypeComment,
    JKEmptyOverlayTypeNews,
    JKEmptyOverlayTypeSearch,
    JKEmptyOverlayTypeImageSet,
    JKEmptyOverlayTypeImageSetRetry,
    JKEmptyOverlayTypeCPN
};

@interface UIView (EmptyOverlay)

- (void)showEmptyOverlay:(BOOL)show tapActionBlock:(void(^)(void))tapActionBlock;
- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type tapActionBlock:(void(^)(void))tapActionBlock;
- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type edgeInsets:(UIEdgeInsets)edgeInsets tapActionBlock:(void(^)(void))tapActionBlock;
- (void)showEmptyOverlay:(BOOL)show type:(JKEmptyOverlayType)type constraintView:(UIView *)view tapActionBlock:(void(^)(void))tapActionBlock;

@end
