//
//  UIViewController+SloppySwiper.m
//  JKNews
//
//  Created by Sid on 21/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIViewController+SloppySwiper.h"
#import "JKMacros.h"

@implementation UIViewController (SloppySwiper)

JKSYNTH_DYNAMIC_PROPERTY_OBJECT(sloppySwiper, setSloppySwiper, RETAIN, SloppySwiper *)

- (void)configureSloppySwiper {
    self.sloppySwiper = [[SloppySwiper alloc] initWithNavigationController:self.navigationController];
    self.navigationController.delegate = self.sloppySwiper;
}

@end
