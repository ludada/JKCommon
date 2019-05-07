//
//  JKStackButton.h
//  JKNews
//
//  Created by Sid on 24/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKStackButton : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *button;


/**
 override point for button action
*/
- (void)onButtonPressed:(UIButton *)sender;

@end
