//
//  JKCircularProgressView.m
//  JKNews
//
//  Created by NEVER.FADE.SOUL on 31/07/2017.
//  Copyright © 2017 people.cn. All rights reserved.
//

#import "UIView+Timer.h"
#import "JKCircularProgressView.h"
#import "JKMultiLanguage.h"

#import <QuartzCore/QuartzCore.h>

@interface JKCircularProgressView () <CAAnimationDelegate> {
//    NSTimeInterval _totalTimeInterval;
//    CADisplayLink *_displayLink; // frame drop...
    NSInteger _decreaseCounter;
    BOOL _isAnimating;
}

@property (nonatomic, strong) UIColor *containerColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *skipLabel;

@end

@implementation JKCircularProgressView

- (void)dealloc {
    [self cancleTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame containerColor:(UIColor *)containerColor progressColor:(UIColor *)progressColor lineWidth:(CGFloat)lineWidth duration:(NSTimeInterval)duration {
    if (self = [super initWithFrame:frame]) {
        _containerColor = containerColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        _duration = duration;
        
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapProgressView:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        [self drawCycle];
        [self configureSkipLabel];
        _isAnimating = NO;
    }
    return self;
}

- (void)didTapProgressView:(UITapGestureRecognizer *)sender {
    if (self.progressViewDelegate && [self.progressViewDelegate respondsToSelector:@selector(didTapCircularProgressView)]) {
        [self.progressViewDelegate didTapCircularProgressView];
    }
}

- (void)configureSkipLabel {
    [self addSubview:self.skipLabel];
    CGSize skipSize = CGSizeMake(CGRectGetWidth(self.bounds) - 2 * _lineWidth, CGRectGetHeight(self.bounds) - 2 * _lineWidth);
    self.skipLabel.frame = CGRectMake((CGRectGetWidth(self.bounds) - skipSize.width) / 2, (CGRectGetHeight(self.bounds) - skipSize.height) / 2, skipSize.width, skipSize.height);
    self.skipLabel.layer.cornerRadius = skipSize.height / 2;
    self.skipLabel.layer.masksToBounds = YES;
    self.skipLabel.userInteractionEnabled = NO;
}

- (void)drawCycle {
    CAShapeLayer *backgroundLayer = [self drawCycleLayerWithCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2) radius:CGRectGetWidth(self.bounds) / 2 - _lineWidth / 2 lineWidth:_lineWidth color:_containerColor];
    [self.layer addSublayer:backgroundLayer];
    
    self.progressLayer = [self drawCycleLayerWithCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2) radius:(CGRectGetWidth(self.bounds) / 2 - _lineWidth / 2) lineWidth:_lineWidth color:_progressColor];
    self.progressLayer.strokeEnd = 0;
    [self.layer addSublayer:self.progressLayer];
}

- (CAShapeLayer *)drawCycleLayerWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:(M_PI + M_PI_2) endAngle:-M_PI_2 clockwise:NO];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.contentsScale = [[UIScreen mainScreen] scale];
    layer.frame = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = lineWidth;
    layer.lineCap = kCALineJoinBevel;
    layer.lineJoin = kCALineJoinBevel;
    layer.path = path.CGPath;
    return layer;
}

- (void)startAnimating {
    _decreaseCounter = (NSInteger)_duration;
    __weak typeof(self) weakSelf = self;
    [self addTimerAtStart:0 interval:1.0f callbackOnMainThread:NO handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf updateSkipLabelText];
    }];
    [self addAnimationFromValue:@1.0f duration:_duration];
    [self addAppBecomeActiveObserver];
    _isAnimating = YES;
}

- (void)addAppBecomeActiveObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationDidBecomeActive {
    if (_isAnimating && _decreaseCounter > 0) {
        [self addAnimationFromValue:@(_decreaseCounter / _duration) duration:_decreaseCounter];
        CFTimeInterval interval = self.progressLayer.timeOffset;
        self.progressLayer.timeOffset = 0;
        self.progressLayer.beginTime = [self.progressLayer convertTime:CACurrentMediaTime() fromLayer:nil] - interval;
    }
}

- (void)addAnimationFromValue:(id)fromValue duration:(CFTimeInterval)duration {
    CABasicAnimation *progressAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    progressAnimation.fromValue = fromValue;
    progressAnimation.toValue = @0;
    progressAnimation.duration = duration;
    progressAnimation.repeatCount = 0;
    progressAnimation.delegate = self;
    [self.progressLayer addAnimation:progressAnimation forKey:@"progress"];
}

- (void)stopAnimating {
    [self cancleTimer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressLayer.speed = 0;
        [self.progressLayer removeAnimationForKey:@"progress"];
    });
    _isAnimating = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!flag) {
        self.progressLayer.timeOffset = [self.progressLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    }
}

#pragma mark - Setters

- (void)setDuration:(NSTimeInterval)duration {
    _duration = MAX(1.0f, duration);
}

#pragma mark - Getter

- (UILabel *)skipLabel {
    if (!_skipLabel) {
        _skipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _skipLabel.font = [UIFont systemFontOfSize:12.0f];
        _skipLabel.textColor = [UIColor whiteColor];
        _skipLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
        _skipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _skipLabel;
}

- (void)updateSkipLabelText {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.skipLabel.text = [NSString stringWithFormat:JKLocalizedString(@"advertisement_skip_time"), [NSNumber numberWithInteger:_decreaseCounter > 0 ? _decreaseCounter : 1]];
        if (_decreaseCounter == 0) {
            _isAnimating = NO;
            [self didTapProgressView:nil];
        } else {
            _decreaseCounter--;
        }
    });
}

@end
