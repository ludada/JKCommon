//
//  MPVolumeView+VolumeSlider.m
//  JKNews
//
//  Created by Sid on 14/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "MPVolumeView+VolumeSlider.h"
#import <AVFoundation/AVFoundation.h>

@implementation MPVolumeView (VolumeSlider)

- (UISlider *)volumeSlider {
    self.showsRouteButton = false;
    self.showsVolumeSlider = false;
    self.hidden = true;
    UISlider *slider = nil;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UISlider class]]) {
            slider = (UISlider *)view;
            slider.continuous = false;
            slider.value = [AVAudioSession sharedInstance].outputVolume;
            break;
        }
    }
    return slider;
}

- (void)setVolume:(CGFloat)volume {
    UISlider *volumeSlider = [self volumeSlider];
    if (volumeSlider) {
        volumeSlider.value = MAX(0, MIN(1, volume));
        [volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

@end
