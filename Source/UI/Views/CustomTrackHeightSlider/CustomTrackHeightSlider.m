//
//  CustomTrackHeightSlider.m
//  JKNews
//
//  Created by Sid on 03/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "CustomTrackHeightSlider.h"

@implementation CustomTrackHeightSlider

- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect customBounds = [super trackRectForBounds:bounds];
    customBounds.size = CGSizeMake(customBounds.size.width, self.trackHeight);
    return customBounds;
}

@end
