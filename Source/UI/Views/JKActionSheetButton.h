//
//  JKActionSheetButton.h
//  JKNews
//
//  Created by Sid on 24/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "JKStackButton.h"

typedef NS_ENUM(NSInteger, JKActionSheetButtonType) {
    JKActionSheetButtonTypeWechat     = 1,
    JKActionSheetButtonTypeMoments    = 1 << 1,
    JKActionSheetButtonTypeWeibo      = 1 << 2,
    JKActionSheetButtonTypeQQ         = 1 << 3,
    JKActionSheetButtonTypeQzone      = 1 << 4,
    JKActionSheetButtonTypeLink       = 1 << 5,
    JKActionSheetButtonTypeFavorite   = 1 << 6,
    JKActionSheetButtonTypeFont       = 1 << 7,
    JKActionSheetButtonTypeDownload   = 1 << 8,
    JKActionSheetButtonTypeSafari     = 1 << 9,
    JKActionSheetButtonTypeRefresh    = 1 << 10
};

@class JKActionSheetButton;

@protocol JKActionSheetButtonDelegate <NSObject>

- (void)didSelectActionSheetButton:(JKActionSheetButton *)button;

@end

@interface JKActionSheetButton : JKStackButton

@property (nonatomic, readonly) JKActionSheetButtonType type;
@property (nonatomic, weak) id<JKActionSheetButtonDelegate> delegate;
@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL selected;

+ (instancetype)buttonWithType:(JKActionSheetButtonType)type;

@end
