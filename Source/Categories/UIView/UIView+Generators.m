//
//  UIView+Generators.m
//  JKNews
//
//  Created by Sid on 27/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+Generators.h"

@implementation UIView (Generators)

+ (instancetype)loadFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
