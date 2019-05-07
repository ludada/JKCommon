//
//  UIScrollView+ScrollDirection.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 15/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIScrollView+ScrollDirection.h"
#import "MAKVONotificationCenter.h"
#import "JKMacros.h"
#import <sys/utsname.h>
#import <objc/runtime.h>

@interface ScrollViewDirectionObserver : NSObject

@property (readonly, strong, nonatomic) UIScrollView *scrollView;
@property (readonly, assign, nonatomic) ScrollViewHorizontalScrollDirection horizontalDirection;
@property (readonly, assign, nonatomic) ScrollViewVerticalScrollDirection verticalDirection;

@end

@implementation ScrollViewDirectionObserver

- (void)dealloc {
    [_scrollView removeObserver:self keyPath:KeyPath(self.scrollView.contentOffset)];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super init]){
        _scrollView = scrollView;
        __weak typeof(self) weakSelf = self;
        [_scrollView addObserver:self keyPath:KeyPath(self.scrollView.contentOffset) options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(MAKVONotification *notification) {
            [weakSelf scrollDirectionWithNotification:notification];
        }];
    }
    return self;
}

- (void)scrollDirectionWithNotification:(MAKVONotification *)notification {
    CGPoint oldPoint = [notification.oldValue CGPointValue];
    CGPoint newPoint = [notification.newValue CGPointValue];
    if (oldPoint.x < newPoint.x) {
        _horizontalDirection = ScrollViewHorizontalScrollDirectionLeft;
    } else if (oldPoint.x > newPoint.x) {
        _horizontalDirection = ScrollViewHorizontalScrollDirectionRight;
    } else {
        _horizontalDirection = ScrollViewHorizontalScrollDirectionNone;
    }
    if (oldPoint.y < newPoint.y) {
        _verticalDirection = ScrollViewVerticalScrollDirectionUp;
    } else if (oldPoint.y > newPoint.y) {
        _verticalDirection = ScrollViewVerticalScrollDirectionDown;
    } else {
        _verticalDirection = ScrollViewVerticalScrollDirectionNone;
    }
}

@end

static NSString * const ScrollViewObserverEnabledAssocationKey = @"ScrollViewObserverEnabledAssocationKey";
static NSString * const ScrollViewDirectionObserverAssocationKey = @"ScrollViewDirectionObserverAssocationKey";

@implementation UIScrollView (ScrollDirection)

- (void)startObservingScrollDirection {
    [self scrollViewObserverEnabled:YES];
}

- (void)stopObservingScrollDirection {
    [self scrollViewObserverEnabled:NO];
}

- (void)scrollViewObserverEnabled:(BOOL)enabled {
    if (self.scrollDirectionObserverEnabled == enabled) { return; }
    objc_setAssociatedObject(self, &ScrollViewObserverEnabledAssocationKey, [NSNumber numberWithBool:enabled], OBJC_ASSOCIATION_RETAIN);
    if (enabled) {
        [self directionObserver];
    } else {
        objc_setAssociatedObject(self, &ScrollViewDirectionObserverAssocationKey, nil, OBJC_ASSOCIATION_RETAIN);
    }
}

- (BOOL)scrollDirectionObserverEnabled {
    NSNumber *scrollObserverEnabled = (NSNumber *)objc_getAssociatedObject(self, &ScrollViewObserverEnabledAssocationKey);
    if (!scrollObserverEnabled) {
        scrollObserverEnabled = [NSNumber numberWithBool:NO];
        objc_setAssociatedObject(self, &ScrollViewObserverEnabledAssocationKey, scrollObserverEnabled, OBJC_ASSOCIATION_RETAIN);
    }
    return [scrollObserverEnabled boolValue];
}

- (ScrollViewHorizontalScrollDirection)horizontalDirection {
    return [[self directionObserver] horizontalDirection];
}

- (ScrollViewVerticalScrollDirection)verticalDirection {
    return [[self directionObserver] verticalDirection];
}

- (ScrollViewDirectionObserver *)directionObserver {
    ScrollViewDirectionObserver *observer = objc_getAssociatedObject(self, &ScrollViewDirectionObserverAssocationKey);
    if (!observer) {
        observer = [[ScrollViewDirectionObserver alloc] initWithScrollView:self];
        objc_setAssociatedObject(self, &ScrollViewDirectionObserverAssocationKey, observer, OBJC_ASSOCIATION_RETAIN);
    }
    return observer;
}

@end
