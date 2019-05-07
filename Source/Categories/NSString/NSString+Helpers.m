//
//  NSString+Helpers.m
//  JKNews
//
//  Created by Sid on 03/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSString+Helpers.h"
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "NSData+Helpers.h"

@implementation NSString (Helpers)

- (BOOL)isValidCellphoneNumber {
    NSError *error = nil;
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"^1[3578][0-9]\\d{8}$"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    if (error) {
        return NO;
    }
    NSInteger count = [regExp numberOfMatchesInString:self
                                              options:NSMatchingReportCompletion
                                                range:NSMakeRange(0, [self length])];
    return (count == 1);
}

- (BOOL)isValidUrlString {
    NSString *urlRegEx =
    @"((http|https)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*‌​|([0-9]*)|([-|_])*))‌​+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}

- (NSString *)URLEncoded {
    if(!self.length)
        return @"";
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    unsigned long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString *)MD5Hashed {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)onlyNumeric {
    return [self stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
}

- (NSString *)base64Encoded {
    NSData *data = [NSData dataWithBytes:[self UTF8String] length:[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    return [data base64String];
}

- (NSString *)hmacSHA256WithSecret:(NSString *)secret {
    secret = secret ?: @"";
    const char *cKey  = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64String];
    return hash;
}

- (NSString *)hmacSHA1WithSecret:(NSString *)secret {
    secret = secret ?: @"";
    const char *cKey  = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64String];
    return hash;
}

- (NSString *)firstCharLowercase {
    if (self.length < 1) { return self; }
    NSRange range = NSMakeRange(0, 1);
    NSString *firstChar = [self substringWithRange:range];
    firstChar = firstChar.lowercaseString;
    return [self stringByReplacingCharactersInRange:range withString:firstChar];
}

- (NSString *)hiddenPhonenumber {
    if (self.length == 0) {
        return @"***";
    } else if (self.length > 5) {
        NSString *prefix = [self substringWithRange:NSMakeRange(0, 3)];
        NSString *postFix = [self substringWithRange:NSMakeRange(self.length - 2, 2)];
        NSString *hidden = [@"" stringByPaddingToLength:self.length - 5 withString:@"*" startingAtIndex:0];
        return [NSString stringWithFormat:@"%@%@%@", prefix, hidden, postFix];
    } else {
        return [@"" stringByPaddingToLength:self.length withString:@"*" startingAtIndex:0];
    }
}

#if DEBUG
- (NSString *)hexRepresentation {
    const char *data = [self UTF8String];
    NSMutableString *string = [NSMutableString stringWithCapacity:self.length * 5];
    while (*data) {
        if (string.length) {
            [string appendFormat:@",0x%02x", *data++ & 0x00FF];
        } else {
            [string appendFormat:@"0x%02x", *data++ & 0x00FF];
        }
    }
    return string;
}
#endif

@end
