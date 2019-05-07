//
//  UIViewController+TopViewController.m
//  JKCommonExample
//
//  Created by Sid on 2018/5/3.
//  Copyright © 2018 Sid. All rights reserved.
//

#import "UIViewController+TopViewController.h"
#import "UIWindow+ViewControllers.h"

@implementation UIViewController (TopViewController)

+ (UIViewController *)topViewController {
    return [[UIApplication sharedApplication].keyWindow visibleViewController];
}

@end
