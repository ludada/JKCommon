//
//  UISearchBar+Appearence.m
//  JKNews
//
//  Created by Sid on 18/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UISearchBar+Appearence.h"

@implementation UISearchBar (Appearence)

- (UITextField *)textFieldFromView:(UIView *)view {
    NSMutableArray<UIView *> *views = @[view].mutableCopy;
    while (1) {
        if (views.count == 0) { break; }
        
        NSArray<UIView *> *arr = views.copy;
        [views removeAllObjects];
        for (UIView *v in arr) {
            if ([v isKindOfClass:[UITextField class]]) {
                return (UITextField *)v;
            } else {
                [views addObjectsFromArray:v.subviews];
            }
        }
    }
    return nil;
}

- (void)configureSearchFieldBackgroundColor:(UIColor *)color {
    [self textFieldFromView:self].backgroundColor = color;
}

- (void)configureSearchTextColor:(UIColor *)color {
    [self textFieldFromView:self].textColor = color;
}

- (void)configurePlaceholderTextColor:(UIColor *)color {
    UILabel *label = [[self textFieldFromView:self] valueForKey:@"placeholderLabel"];
    if (label && [label isKindOfClass:[UILabel class]]) {
        label.textColor = color;
    }
    
}

@end
