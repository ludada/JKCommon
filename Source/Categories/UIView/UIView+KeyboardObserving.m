//
//  UIView+KeyboardObserving.m
//  JKNews
//
//  Created by Sid on 07/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+KeyboardObserving.h"
#import "JKMacros.h"

@implementation UIView (KeyboardObserving)

JKSYNTH_DYNAMIC_PROPERTY_OBJECT(keyboardObservingCompletion, setKeyboardObservingCompletion, COPY, KeyboardObservingCompletion)

- (void)startObservingKeyboardNotification:(KeyboardObservingCompletion)completion {
    self.keyboardObservingCompletion = completion;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)stopObservingKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (!userInfo) {
        return;
    }
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration ?: 0.25
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionOverrideInheritedOptions
                     animations:^{
                         self.keyboardObservingCompletion(keyboardFrame.size.height);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (!userInfo) {
        return;
    }
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration ?: 0.25
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionOverrideInheritedOptions
                     animations:^{
                         self.keyboardObservingCompletion(0);
                     } completion:^(BOOL finished) {
                         
                     }];
}

@end
