//
//  UIScrollView+ScrollDirection.h
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 15/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScrollViewHorizontalScrollDirection) {
    ScrollViewHorizontalScrollDirectionNone  = 0,
    ScrollViewHorizontalScrollDirectionLeft  = 1,
    ScrollViewHorizontalScrollDirectionRight = 2
};

typedef NS_ENUM(NSInteger, ScrollViewVerticalScrollDirection) {
    ScrollViewVerticalScrollDirectionNone = 0,
    ScrollViewVerticalScrollDirectionUp   = 1,
    ScrollViewVerticalScrollDirectionDown = 2
};

@interface UIScrollView (ScrollDirection)

@property (nonatomic, assign, readonly) BOOL scrollDirectionObserverEnabled;
@property (nonatomic, assign, readonly) ScrollViewHorizontalScrollDirection horizontalDirection;
@property (nonatomic, assign, readonly) ScrollViewVerticalScrollDirection verticalDirection;

- (void)startObservingScrollDirection;
- (void)stopObservingScrollDirection;

@end
