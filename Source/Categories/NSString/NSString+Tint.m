//
//  NSString+Tint.m
//  JKNews
//
//  Created by Sid on 19/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSString+Tint.h"

@implementation NSString (Tint)

- (NSMutableAttributedString *)attributedStringByTintSubString:(NSString *)subString color:(UIColor *)color {
    NSMutableAttributedString *mutableString = nil;
    mutableString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSString *pattern = subString;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    NSRange range = NSMakeRange(0,[self length]);
    [expression enumerateMatchesInString:self options:0 range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange range = [result rangeAtIndex:0];
        [mutableString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }];
    
    return mutableString;
}

@end
