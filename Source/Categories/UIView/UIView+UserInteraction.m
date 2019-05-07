//
//  UIView+UserInteraction.m
//  JKNews
//
//  Created by Sid on 06/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+UserInteraction.h"

@implementation UIView (UserInteraction)

- (void)delayNextTouch {
    [self delayNextTouchBy:0.2];
}

- (void)delayNextTouchBy:(NSTimeInterval)time {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}

@end
