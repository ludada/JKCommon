//
//  UIView+MBProgressHUD.h
//  JKNews
//
//  Created by Sid on 01/08/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MBProgressHUD)

- (MBProgressHUD *)showHUDWithText:(NSString *)text;
- (MBProgressHUD *)showHUDWithText:(NSString *)text automaticallyHide:(BOOL)hide;
- (MBProgressHUD *)showHUDWithText:(NSString *)text automaticallyHide:(BOOL)hide completion:(nullable void(^)(void))completion;
- (MBProgressHUD *)showProgressHUDWithtext:(NSString *)text;
- (MBProgressHUD *)showProgressHUDWithtext:(NSString *)text automaticallyHide:(BOOL)hide;
- (MBProgressHUD *)showProgressHUDWithtext:(NSString *)text automaticallyHide:(BOOL)hide completion:(nullable void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
