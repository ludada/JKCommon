//
//  NSString+Tint.h
//  JKNews
//
//  Created by Sid on 19/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Tint)

- (NSMutableAttributedString *)attributedStringByTintSubString:(NSString *)subString color:(UIColor *)color;

@end
