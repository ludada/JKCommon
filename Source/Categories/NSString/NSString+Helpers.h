//
//  NSString+Helpers.h
//  JKNews
//
//  Created by Sid on 03/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

- (BOOL)isValidCellphoneNumber;
- (BOOL)isValidUrlString;

- (NSString *)URLEncoded;
- (NSString *)MD5Hashed;
- (NSString *)onlyNumeric;
- (NSString *)base64Encoded;
- (NSString *)hmacSHA256WithSecret:(NSString*)secret;
- (NSString *)hmacSHA1WithSecret:(NSString*)secret;
- (NSString *)firstCharLowercase;
- (NSString *)hiddenPhonenumber;
#if DEBUG
- (NSString *)hexRepresentation;
#endif

@end
