//
//  BigThumbSlider.m
//  JKNews
//
//  Created by Sid on 03/10/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "BigThumbSlider.h"

@implementation BigThumbSlider

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    CGRect thumbRect = CGRectInset([super thumbRectForBounds:bounds trackRect:rect value:value], -20 , -20);
    return thumbRect;
}

@end
