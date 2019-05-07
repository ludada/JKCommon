//
//  UIButton+Block.h
//  JKNews
//
//  Created by Sid on 22/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)

- (void)addActionBlock:(void(^)(UIButton *button))actionBlock;

@end
