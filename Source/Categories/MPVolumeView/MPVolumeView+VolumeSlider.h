//
//  MPVolumeView+VolumeSlider.h
//  JKNews
//
//  Created by Sid on 14/09/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MPVolumeView (VolumeSlider)

- (UISlider *)volumeSlider;
- (void)setVolume:(CGFloat)volume;

@end
