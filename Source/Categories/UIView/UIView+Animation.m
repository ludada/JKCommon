//
//  UIView+Animation.m
//  JKNews
//
//  Created by Sid on 04/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)shrinkBounce {
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)stretchBounce {
    self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

@end
