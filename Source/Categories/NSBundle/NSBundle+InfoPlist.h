//
//  NSBundle+InfoPlist.h
//  JKNews
//
//  Created by Sid on 03/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (InfoPlist)

- (NSString *)identifier;
- (NSString *)versionString;
- (NSString *)executableName;
- (NSString *)shortVersionString;
- (NSString *)displayName;
- (NSString *)appIcon;
- (NSString *)launchImage;
- (NSString *)shareDisplayName;
@end

NS_ASSUME_NONNULL_END
