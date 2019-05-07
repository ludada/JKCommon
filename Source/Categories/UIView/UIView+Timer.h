//
//  UIView+Timer.h
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 07/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Timer)

- (void)addTimerAtStart:(NSTimeInterval)start interval:(NSTimeInterval)interval callbackOnMainThread:(BOOL)onMainThread handler:(void (^)(void))handler;
- (void)cancleTimer;

@end
