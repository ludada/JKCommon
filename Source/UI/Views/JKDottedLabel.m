//
//  JKDottedLabel.m
//  JKNews
//
//  Created by Sid on 29/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "JKDottedLabel.h"
#import <Masonry/Masonry.h>

@implementation JKDottedLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        [self configureDottedImage];
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)configureDottedImage {
    UIImageView *topImageView = [self dottedImageView];
    [self addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    UIImageView *bottomImageView = [self dottedImageView];
    [self addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (UIImageView *)dottedImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"dotted_label_lace"];
    return imageView;
}

@end
