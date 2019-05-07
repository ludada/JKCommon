//
//  NSBundle+InfoPlist.m
//  JKNews
//
//  Created by Sid on 03/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "NSBundle+InfoPlist.h"

@implementation NSBundle (InfoPlist)

- (NSString *)identifier {
    return self.infoDictionary[(id)kCFBundleIdentifierKey] ?: @"";
}

- (NSString *)versionString {
    return self.infoDictionary[(id)kCFBundleVersionKey] ?: @"";
}

- (NSString *)executableName {
    return self.infoDictionary[(id)kCFBundleExecutableKey] ?: @"";
}

- (NSString *)shortVersionString {
    return self.infoDictionary[@"CFBundleShortVersionString"] ?: @"";
}

- (NSString *)displayName {
    return self.infoDictionary[@"CFBundleDisplayName"] ?: @"";
}

- (NSString *)appIcon{
    NSArray *inforArray = self.infoDictionary[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    return inforArray.lastObject ? : @"";
}

- (NSString *)launchImage{
    NSArray *launchImageArray = self.infoDictionary[(id)@"UILaunchImages"];
    for (NSDictionary *dic in launchImageArray){
        CGSize imageSize = CGSizeFromString(dic[(id)@"UILaunchImageSize"]);
        if (imageSize.width == CGRectGetWidth([UIScreen mainScreen].bounds) && imageSize.height == CGRectGetHeight([UIScreen mainScreen].bounds)) {
            return dic[(id)@"UILaunchImageName"];
        }
    }
    return @"";
}

- (NSString *)shareDisplayName {
    return @"中国共产党新闻";
}

@end
