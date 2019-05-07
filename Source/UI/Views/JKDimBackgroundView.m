//
//  JKDimBackgroundView.m
//  
//
//  Created by Sid on 24/07/2017.
//
//

#import "JKDimBackgroundView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Generators.h"

@interface JKDimBackgroundView () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView<JKDimBackgroudViewAccessoryViewProtocol> *accessoryView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation JKDimBackgroundView

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addGestureRecognizer:self.tap];
        self.tap.enabled = NO;
        self.tap.delegate = self;
        [self configureBackgroundView];
    }
    return self;
}

- (void)configureBackgroundView {
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)configureAccessoryView:(UIView<JKDimBackgroudViewAccessoryViewProtocol> *)accessoryView {
    self.accessoryView = accessoryView;
    [self addSubview:self.accessoryView];
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.mas_bottom);
    }];
    [self layoutIfNeeded];
}

- (void)showToView:(UIView *)view withAccessoryView:(UIView<JKDimBackgroudViewAccessoryViewProtocol> *)accessoryView {
    [self configureAccessoryView:accessoryView];
    
    self.backgroundView.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionOverrideInheritedOptions
                     animations:^{
                         self.backgroundView.alpha = 1;
                         self.accessoryView.transform = CGAffineTransformMakeTranslation(0, - CGRectGetHeight(self.accessoryView.bounds));
                     } completion:^(BOOL finished) {
                         self.tap.enabled = YES;
                     }];
}

- (void)showWithAccessoryView:(UIView<JKDimBackgroudViewAccessoryViewProtocol> *)accessoryView {
    [self showToView:[UIApplication sharedApplication].keyWindow.rootViewController.view withAccessoryView:accessoryView];
}

- (void)hideWithCompletion:(void (^)(UIView<JKDimBackgroudViewAccessoryViewProtocol> *))completion {
    self.backgroundView.alpha = 1;
    self.tap.enabled = NO;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionOverrideInheritedOptions | UIViewAnimationCurveEaseIn
                     animations:^{
                         self.backgroundView.alpha = 0;
                         self.accessoryView.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         if (completion) {
                             completion(self.accessoryView);
                         }
                     }];
}

- (void)cancel {
    [self.accessoryView hideWithCompletion:nil];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];
    BOOL should = !CGRectContainsPoint(self.accessoryView.frame, location);
    return should;
}

#pragma mark - getters

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor colorWithRGBHex:0x000000 alpha:0.4f];//[AppConfiguration dimBackgroundViewBackgroundColor];
        _backgroundView.userInteractionEnabled = NO;
    }
    return _backgroundView;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    }
    return _tap;
}

@end
