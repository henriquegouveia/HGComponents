//
//  HGRingChartSlice.m
//
//  Created by Henrique Gouveia on 8/22/14.
//  Copyright (c) 2014 Gouveia. All rights reserved.
//

#import "HGRingChartSlice.h"

typedef enum
{
    HGRingChartModeZero = 0,
    HGRingChartModeIncrease,
    HGRingChartModeDecrease
}HGRingChartMode;

@interface HGRingChartSlice ()

@property (nonatomic) NSInteger lineWidth;
@property (nonatomic) NSTimeInterval duration;

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat percentage;
@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat velocity;

@property (copy, nonatomic) RingChartSliceCompletionBlock completionBlock;
@property (copy, nonatomic) RingChartUpdateValueCompletionBlock updatePercentageBlock;

@property (nonatomic) HGRingChartMode mode;

@property (copy, nonatomic) NSArray *progressColors;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HGRingChartSlice

- (id)initWithFrame:(CGRect)frame
         startAngle:(CGFloat)angle
     progressColors:(NSArray *)progressColors
          lineWidth:(NSInteger)lineWidth
         percentage:(CGFloat)percentage
           velocity:(CGFloat)velocity
  animationDuration:(NSTimeInterval)animationDuration
  currentPercentage:(RingChartUpdateValueCompletionBlock)percentageBlock
         completion:(RingChartSliceCompletionBlock)completionBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _progressColors = progressColors;
        _lineWidth = lineWidth;
        _startAngle = angle;
        _duration = animationDuration;
        _velocity = velocity;
        _percentage = percentage;
        
        _updatePercentageBlock = percentageBlock;
        _completionBlock = completionBlock;
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
    CGFloat circleStartAngle = self.startAngle;
    
    CGFloat progressCircleEndAngle = (CGFloat)(self.startAngle + [self progress] * 2 * M_PI);
    
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
        [self setNeedsDisplay];
        self.updatePercentageBlock((self.progress * 100));
    } else {
        [[self timer] invalidate];
        [self setMode:HGRingChartModeZero];
        self.completionBlock(YES, (self.progress * 100));
    }
}

- (void)decreaseProgressCircle
{
    self.progress -= self.velocity;
    
    if (self.progress && (self.progress >= (self.percentage / 100))) {
        [self setNeedsDisplay];
        self.updatePercentageBlock((self.progress * 100));
    } else {
        self.completionBlock(YES, (self.progress * 100));
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
