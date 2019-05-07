//
//  UIView+UserInteraction.h
//  JKNews
//
//  Created by Sid on 06/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UserInteraction)

- (void)delayNextTouch;
- (void)delayNextTouchBy:(NSTimeInterval)time;

@end
