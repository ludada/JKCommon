//
//  UIView+Timer.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 07/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+Timer.h"
#import "JKMacros.h"

@implementation UIView (Timer)

JKSYNTH_DYNAMIC_PROPERTY_OBJECT(timer, setTimer, RETAIN, dispatch_source_t)
JKSYNTH_DYNAMIC_PROPERTY_OBJECT(callbackHandler, setCallbackHandler, COPY, void (^)(void))

- (void)addTimerAtStart:(NSTimeInterval)start interval:(NSTimeInterval)interval callbackOnMainThread:(BOOL)onMainThread handler:(void (^)(void))handler {
    NSAssert(handler, @"Callback handler should not be nil.");
    self.callbackHandler = [handler copy];
    [self cancleTimer];
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(start * NSEC_PER_SEC)), (int64_t)(interval * NSEC_PER_SEC), (int64_t)(0.1f * NSEC_PER_SEC));
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (onMainThread) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf onTimerArrival];
            });
        } else {
            [strongSelf onTimerArrival];
        }
    });
    dispatch_resume(self.timer);
}

- (void)onTimerArrival {
    if (self.callbackHandler) {
        self.callbackHandler();
    }
}

- (void)cancleTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}

@end
