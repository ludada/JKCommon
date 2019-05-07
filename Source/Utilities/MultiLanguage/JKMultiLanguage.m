//
//  JKMultiLanguage.m
//  JKNews
//
//  Created by Sid on 28/06/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "JKMultiLanguage.h"
#import "NSArray+Getters.h"
#import "NSMutableArray+Setters.h"
#import "NSDictionary+Getters.h"

@implementation JKMultiLanguage

static NSString * const CurrentLanguageKey = @"CurrentLanguage";
static NSArray<NSDictionary<NSString *, NSString*> *> *LocalizedStringArray;
static NSString * const StringsFileExtension = @"strings";
static BOOL HasInitialized = NO;

+ (void)initializeIfNeeded {
    @synchronized (self) {
        if (HasInitialized == NO) {
            [self initialize];
            HasInitialized = YES;
        }
    }
}

+ (NSArray<NSString *> *)supportedLanguages {
    return @[@"zh-Hans"];
}

+ (void)initialize {
    NSArray<NSString *> *localizedStringFileNameArray = [self supportedLanguages];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSUInteger i = 0; i < localizedStringFileNameArray.count; i++) {
        NSURL * URL = [[NSBundle mainBundle] URLForResource:localizedStringFileNameArray[i] withExtension:StringsFileExtension];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:URL];
        [arr addObjectSafely:dict];
    }
    LocalizedStringArray = arr;
}

+ (JKMultiLanguageType)currentLanguateType {
    return [[NSUserDefaults standardUserDefaults] integerForKey:CurrentLanguageKey];
}

+ (NSString *)localizedString:(NSString *)key {
    [self initializeIfNeeded];
    if (key == nil || key.length < 1) {
        return nil;
    }
    NSString *string = [[LocalizedStringArray objectSafelyAtIndex:[self currentLanguateType]] stringForKeySafely:key];
    return string ?: nil;
}

@end
