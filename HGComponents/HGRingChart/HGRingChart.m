//
//  HGRingChart.m
//  HGFramework
//
//  Created by Henrique Gouveia on 10/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGRingChart.h"

@interface HGRingChart ()

@property (nonatomic) UIColor *backColor;
@property (nonatomic) UIColor *progressColor;
@property (nonatomic, assign) CGFloat percentage;
@property (nonatomic, assign) NSInteger lineWidth;
@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HGRingChart

- (id) initWithFrame:(CGRect)frame
           backColor:(UIColor *)backColor
       progressColor:(UIColor *)progressColor
           lineWidth:(NSInteger)lineWidth
          percentage:(CGFloat)percentage
   animationDuration:(NSTimeInterval)animationDuration
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _backColor = backColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        _duration = 0.001f;
        _percentage = percentage;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
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
    
    if (self.progress)
    {
        CGFloat progressCircleEndAngle = (CGFloat)(- M_PI_2 + [self progress] * 2 * M_PI);
        
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:circlePoint
                                                                      radius:circleRadius
                                                                  startAngle:circleStartAngle
                                                                    endAngle:progressCircleEndAngle
                                                                   clockwise:YES];
        
        [[self progressColor] setStroke];
        
        progressCircle.lineWidth = (CGFloat)self.lineWidth;
        
        [progressCircle stroke];
    } else {
        [[self timer] invalidate];
    }
}

- (void) updateProgressCircle
{
    if (self.progress > ((self.percentage/1.8) / 100))
        self.progress = self.progress + (self.duration/(self.progress * 10));
    else
        self.progress = self.progress + self.duration;
    
    if (self.progress && [self progress] <= [self percentage]/100) {
        [self setNeedsDisplay];
        [self.delegate updatePercentage:self.progress];
    }
}

#pragma mark - Actions

- (void)startAnimation
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];
}

@end
