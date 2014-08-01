//
//  HGProgressLine.m
//  BDMStepsMenu
//
//  Created by Henrique Gouveia on 7/2/14.
//  Copyright (c) 2014 Gouveia. All rights reserved.
//

#import "HGProgressLine.h"

@interface HGProgressLine ()

@property (nonatomic) CGFloat count;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat lineWidth;

@property (strong, nonatomic) NSTimer *timer;

@property (copy, nonatomic) NSArray *gradientColors;
@property (copy, nonatomic) HGStepCompletinoBlock completion;

@end

@implementation HGProgressLine

- (id)initWithFrame:(CGRect)frame
          lineWidth:(CGFloat)lineWidth
             colors:(NSArray *)colors
        forDuration:(CGFloat)duration
           progress:(CGFloat)progress
withCompletionBlock:(HGStepCompletinoBlock)completion
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _position = CGPointMake(0, CGRectGetHeight([self bounds])/2);
        _duration = duration;
        _completion = completion;
        _lineWidth = lineWidth;
        _gradientColors = colors;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self startAnimation];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *gradientColors = self.gradientColors;
    CGFloat gradientLocations[] = {0.0f, 1.0f};
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)gradientColors, gradientLocations);
    
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f,
                                                                                            (self.frame.size.height/2),
                                                                                            self.count,
                                                                                            self.lineWidth)
                                                                    cornerRadius:0];
    
    CGContextSaveGState(context);
    [roundedRectanglePath fill];
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, self.position, CGPointMake(self.count, CGRectGetHeight([self bounds])/2), 0);
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
}

- (void)startAnimation
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

- (void)updateView
{
    self.count += 5.0f;
    
    if (self.count <= self.frame.size.height)
    {
        [self setNeedsDisplay];
    } else {
        self.completion(YES);
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
