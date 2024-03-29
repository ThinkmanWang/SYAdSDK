//
//  SYDrawingCircleProgressButton.m
//  Masonry
//
//  Created by 王晓丰 on 2021/5/19.
//


#import "SYDrawingCircleProgressButton.h"

#define JXDegreeToRadian(x) ((x) * M_PI / 180.f)


@interface SYDrawingCircleProgressButton () <CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, copy) SYDrawingCircleProgressCompletionHanlder completionHandler;

@end

@implementation SYDrawingCircleProgressButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:self.trackLayer];
    }
    return self;
}


#pragma mark -
#pragma mark Public API

- (void)startProgressAnimationWithDuration:(double)duration completionHandler:(SYDrawingCircleProgressCompletionHanlder)completionHandler;
{
    self.completionHandler = completionHandler;
    
    [self.layer addSublayer:self.progressLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = @.0;
    pathAnimation.toValue = @1.f;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.delegate = self;
    [_progressLayer addAnimation:pathAnimation forKey:nil];
}


#pragma mark -
#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
{
    if (flag && NULL != self.completionHandler) {
        self.completionHandler(self);
    }
}


#pragma mark -
#pragma mark Getters

- (CAShapeLayer *)trackLayer
{
    if (nil == _trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.bounds;
        _trackLayer.fillColor = self.fillColor.CGColor ?: [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.3].CGColor ;
        _trackLayer.lineWidth = self.lineWidth ?: 2.f;
        _trackLayer.strokeColor = self.trackColor.CGColor ?: [UIColor whiteColor].CGColor;
        _trackLayer.strokeStart = 0.f;
        _trackLayer.strokeEnd = 1.f;
        
        _trackLayer.path = self.bezierPath.CGPath;
    }
    
    return _trackLayer;
}

- (UIBezierPath *)bezierPath
{
    if (nil == _bezierPath) {
        CGFloat width = CGRectGetWidth(self.frame) / 2.f;
        CGFloat height = CGRectGetHeight(self.frame) / 2.f;
        CGPoint centerPoint = (CGPoint) {.x = width, .y = height};
        
        CGFloat radius = CGRectGetWidth(self.frame) / 2.f;
        
        _bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:JXDegreeToRadian(-90) endAngle:JXDegreeToRadian(270) clockwise:YES];
    }
    
    return _bezierPath;
}

- (CAShapeLayer *)progressLayer
{
    if (nil == _progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = self.lineWidth ?: 2.f;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeColor = self.progressColor.CGColor ?: self.fillColor.CGColor ?: [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.2].CGColor ;
        _progressLayer.strokeStart = 0.f;
        
        _progressLayer.path = self.bezierPath.CGPath;
    }
    return _progressLayer;
}

@end

