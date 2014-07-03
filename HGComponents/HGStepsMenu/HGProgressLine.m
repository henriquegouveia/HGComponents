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

@property (copy, nonatomic) UIColor *color;
@property (copy, nonatomic) HGStepCompletinoBlock completion;

@end

@implementation HGProgressLine

- (id)initWithFrame:(CGRect)frame
          lineWidth:(CGFloat)lineWidth
              color:(UIColor *)color
        forDuration:(CGFloat)duration
withCompletionBlock:(HGStepCompletinoBlock)completion
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _position = CGPointMake(0, CGRectGetHeight([self bounds])/2);
        _duration = duration;
        _completion = completion;
        _lineWidth = lineWidth;
        _color = color;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self startAnimation];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    
    UIBezierPath *lineBetweenSteps = [UIBezierPath bezierPath];
    lineBetweenSteps.lineWidth = 2.0f;
    [lineBetweenSteps moveToPoint:self.position];
    [lineBetweenSteps addLineToPoint:CGPointMake(self.count, CGRectGetHeight([self bounds])/2)];
    [lineBetweenSteps stroke];
}

- (void)startAnimation
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

- (void)updateView
{
    self.count += 1.0f;
    
    if (self.count < self.frame.size.width)
    {
        [self setNeedsDisplay];
    } else {
        self.completion(YES);
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
