//
//  UIImage+Generators.h
//  JKNews
//
//  Created by Sid on 27/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Generators)

+ (UIImage *)resizableImageWithColor:(UIColor *)color;
+ (UIImage *)snapshotImageFromView:(UIView *)view;
- (UIImage*)grayscaleImage;
- (UIImage*)imageWithWidth:(CGFloat)width;
- (UIImage *)clipImageInRect:(CGRect)rect;

@end
