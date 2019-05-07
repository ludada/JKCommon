//
//  UIButton+Block.m
//  JKNews
//
//  Created by Sid on 22/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIButton+Block.h"
#import "JKMacros.h"

@implementation UIButton (Block)

JKSYNTH_DYNAMIC_PROPERTY_OBJECT(actionBlock, setActionBlock, RETAIN, void(^)(UIButton *button))

- (void)addActionBlock:(void (^)(UIButton *))actionBlock {
    self.actionBlock = [actionBlock copy];
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUpInside:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

@end
