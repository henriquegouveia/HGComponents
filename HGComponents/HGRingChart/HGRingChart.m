//
//  HGRingChart.m
//  HGFramework
//
//  Created by Henrique Gouveia on 10/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGRingChart.h"

typedef enum
{
    HGRingChartModeZero = 0,
    HGRingChartModeIncrease,
    HGRingChartModeDecrease
}HGRingChartMode;

@interface HGRingChart ()

@property (nonatomic) UIColor *backColor;
@property (nonatomic) NSInteger lineWidth;
@property (nonatomic) NSTimeInterval duration;

@property (nonatomic) CGFloat percentage;
@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat velocity;

@property (nonatomic) HGRingChartMode mode;

@property (copy, nonatomic) NSArray *progressColors;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HGRingChart

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
     progressColors:(NSArray *)progressColors
          lineWidth:(NSInteger)lineWidth
         percentage:(CGFloat)percentage
           velocity:(CGFloat)velocity
  animationDuration:(NSTimeInterval)animationDuration
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _backColor = backColor;
        _progressColors = progressColors;
        _lineWidth = lineWidth;
        _duration = animationDuration;
        _velocity = velocity;
        _percentage = percentage;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *gradientColors = self.progressColors;
    CGFloat gradientLocations[] = {0.0f, 1.0f};
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)gradientColors, gradientLocations);
    
    CGPoint circlePoint = CGPointMake(CGRectGetWidth([self bounds])/2, CGRectGetHeight([self bounds])/2);
    CGFloat circleRadius = (CGRectGetWidth([self bounds]) - [self lineWidth]) / 2;
    CGFloat circleStartAngle = (CGFloat) - M_PI_2;
    CGFloat backCircleEndAngle = (CGFloat)(1.5 * M_PI);
    
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:circlePoint
                                                              radius:circleRadius
                                                          startAngle:circleStartAngle
                                                            endAngle:backCircleEndAngle
                                                           clockwise:YES];
    
    [[self backColor] setStroke];
    [backCircle setLineWidth:(CGFloat)[self lineWidth]];
    [backCircle stroke];
    
    CGFloat progressCircleEndAngle = (CGFloat)(- M_PI_2 + [self progress] * 2 * M_PI);
    
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:circlePoint
                                                                  radius:circleRadius
                                                              startAngle:circleStartAngle
                                                                endAngle:progressCircleEndAngle
                                                               clockwise:YES];
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextAddPath(context, progressCircle.CGPath);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    
    //  Draw a linear gradient from top to bottom
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(self.frame.size.width, 0), 0);
    CGContextRestoreGState(context);
    
    [self startAnimation];
}

- (void)updatePercentage:(CGFloat)percentage
{
    self.duration = 0.002f;
    
    if (percentage < (self.progress * 100))
    {
        [self setMode:HGRingChartModeDecrease];
    } else {
        [self setMode:HGRingChartModeIncrease];
    }
    
    [self setPercentage:percentage];
    [self startAnimation];
}

- (void)updateChart
{
    switch (self.mode) {
        case HGRingChartModeIncrease:
            [self increaseProgressCircle];
            break;
        case HGRingChartModeDecrease:
            [self decreaseProgressCircle];
            break;
        default:
            [self increaseProgressCircle];
            break;
    }
}

- (void)increaseProgressCircle
{
    self.progress += self.velocity;
    
    if (self.progress && (self.progress <= (self.percentage / 100))) {
        
        if (self.progress > ((self.percentage * 0.8f) / 100))
        {
            self.duration += 0.0002;
        } else if (self.progress > ((self.percentage * 0.9f) / 100)) {
            self.duration += 0.0004;
        }
        
        [self setNeedsDisplay];
        [self.delegate updatePercentage:self.progress];
    } else {
        [self.delegate updatePercentage:self.progress];
        [[self timer] invalidate];
        [self setMode:HGRingChartModeZero];
    }
}

- (void)decreaseProgressCircle
{
    self.progress -= self.velocity;
    
    if (self.progress && (self.progress >= (self.percentage / 100))) {
        
        if (self.progress < ((self.percentage * 0.9f) / 100))
        {
            self.duration += 0.0002;
        } else if (self.progress < ((self.percentage * 0.8f) / 100)) {
            self.duration += 0.0004;
        }
        
        [self setNeedsDisplay];
        [self.delegate updatePercentage:self.progress];
    } else {
        [self.delegate updatePercentage:self.progress];
        [[self timer] invalidate];
        [self setMode:HGRingChartModeZero];
    }
}

#pragma mark - Actions

- (void)startAnimation
{
    [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(updateChart) userInfo:nil repeats:NO];
}

@end
