//
//  UIViewController+SloppySwiper.h
//  JKNews
//
//  Created by Sid on 21/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SloppySwiper/SloppySwiper.h>

@interface UIViewController (SloppySwiper)

@property (nonatomic, strong, readonly) SloppySwiper *sloppySwiper;
- (void)configureSloppySwiper;

@end
