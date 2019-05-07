//
//  UIWindow+ViewControllers.h
//  JKNews
//
//  Created by Sid on 18/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (ViewControllers)

- (UIViewController *)visibleViewController;
+ (UIViewController *)visibleViewControllerFrom:(UIViewController *)viewController;

@end
