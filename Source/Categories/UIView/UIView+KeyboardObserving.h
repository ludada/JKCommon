//
//  UIView+KeyboardObserving.h
//  JKNews
//
//  Created by Sid on 07/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KeyboardObservingCompletion)(CGFloat keyboardHeight);

@interface UIView (KeyboardObserving)

- (void)startObservingKeyboardNotification:(KeyboardObservingCompletion)completion;
- (void)stopObservingKeyboardNotification;

@end
