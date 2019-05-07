//
//  UIWindow+ViewControllers.m
//  JKNews
//
//  Created by Sid on 18/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIWindow+ViewControllers.h"

@implementation UIWindow (ViewControllers)

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow visibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)visibleViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [UIWindow visibleViewControllerFrom:[((UINavigationController *)viewController) visibleViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [UIWindow visibleViewControllerFrom:[((UITabBarController *)viewController) selectedViewController]];
    } else if (viewController.presentedViewController) {
        return [UIWindow visibleViewControllerFrom:viewController.presentedViewController];
    } else {
        return viewController;
    }
}

@end
