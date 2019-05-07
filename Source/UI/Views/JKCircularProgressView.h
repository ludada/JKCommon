//
//  JKCircularProgressView.h
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 31/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKCircularProgressViewDelegate <NSObject>

@optional
- (void)didTapCircularProgressView;

@end

@interface JKCircularProgressView : UIView

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, weak) id <JKCircularProgressViewDelegate> progressViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame containerColor:(UIColor *)containerColor progressColor:(UIColor *)progressColor lineWidth:(CGFloat)lineWidth duration:(NSTimeInterval)duration;
- (void)startAnimating;
- (void)stopAnimating;

@end
