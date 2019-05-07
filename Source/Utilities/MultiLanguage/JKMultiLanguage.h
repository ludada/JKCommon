//
//  JKMultiLanguage.h
//  JKNews
//
//  Created by Sid on 28/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JKLocalizedString(key) [JKMultiLanguage localizedString:key] ?: key

typedef NS_ENUM(NSInteger, JKMultiLanguageType) {
    JKMultiLanguageTypeSimplifiedChinese = 0,
};

@interface JKMultiLanguage : NSObject

+ (NSString *)localizedString:(NSString *)key;

@end
