//
//  UIView+MBProgressHUD.m
//  JKNews
//
//  Created by Sid on 01/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+MBProgressHUD.h"
#import "UIColor+Generators.h"

@implementation UIView (MBProgressHUD)

static NSTimeInterval const automaticallyHideDelay = 1.5;

- (void)configureScrollEnabled:(BOOL)scrollEnabled {
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = scrollEnabled;
    }
}

- (MBProgressHUD *)showHUDWithText:(NSString *)text automaticallyHide:(BOOL)hide completion:(void (^)(void))completion {
    return [self showHUDWithText:text mode:MBProgressHUDModeText automaticallyHide:hide completion:completion];
}

- (MBProgressHUD *)showHUDWithText:(NSString *)text automaticallyHide:(BOOL)hide {
    return [self showHUDWithText:text automaticallyHide:hide completion:nil];
}

- (MBProgressHUD *)showHUDWithText:(NSString *)text {
    return [self showHUDWithText:text automaticallyHide:NO completion:nil];
}

- (MBProgressHUD *)showProgressHUDWithtext:(NSString *)text automaticallyHide:(BOOL)hide completion:(void (^)(void))completion {
    return [self showHUDWithText:text mode:MBProgressHUDModeIndeterminate automaticallyHide:hide completion:nil];
}

- (MBProgressHUD *)showProgressHUDWithtext:(NSString *)text automaticallyHide:(BOOL)hide {
    return [self showProgressHUDWithtext:text automaticallyHide:hide completion:nil];
}

- (MBProgressHUD *)showProgressHUDWithtext:(NSString *)text {
    return [self showProgressHUDWithtext:text automaticallyHide:NO completion:nil];
}

- (MBProgressHUD *)showHUDWithText:(NSString *)text mode:(MBProgressHUDMode)mode automaticallyHide:(BOOL)hide completion:(void (^)(void))completion {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.userInteractionEnabled = NO;
    HUD.mode = mode;
    HUD.label.text = text;
    [self configureScrollEnabled:NO];
    HUD.completionBlock = ^() {
        [self configureScrollEnabled:YES];
        if (completion) { completion(); }
    };
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.backgroundColor = [UIColor colorWithR:74 G:74 B:74 A:0.95];
    [self addSubview:HUD];
    [HUD showAnimated:YES];
    if (hide) {
        [HUD hideAnimated:YES afterDelay:automaticallyHideDelay];
    }
    return HUD;
}

@end
