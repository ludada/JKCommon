//
//  NSData+Helpers.h
//  JKCommonExample
//
//  Created by Sid on 2018/6/5.
//  Copyright © 2018 Sid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Helpers)
- (NSString *)hexadecimalString;
- (NSString *)MD5String;
- (NSString *)base64String;
- (NSData *)SHA1Hashed;
@end
