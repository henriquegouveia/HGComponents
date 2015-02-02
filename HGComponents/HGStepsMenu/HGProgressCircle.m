//
//  HGProgressCircle.m
//  BDMStepsMenu
//
//  Created by Henrique Gouveia on 7/2/14.
//  Copyright (c) 2014 Gouveia. All rights reserved.
//

#import "HGProgressCircle.h"

@interface HGProgressCircle ()

@property (nonatomic) CGFloat count;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat lineWidth;

@property (strong, nonatomic) NSTimer *timer;

@property (copy, nonatomic) UIColor *color;
@property (copy, nonatomic) NSArray *gradientColors;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) HGStepCompletinoBlock completion;

@end

@implementation HGProgressCircle

- (id)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth
          imageName:(NSString *)imageName
     colors:(NSArray *)colors
        forDuration:(CGFloat)duration
withCompletionBlock:(HGStepCompletinoBlock)completion
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _count = 180.0f;
        _position = CGPointMake(CGRectGetWidth([self bounds])/2, CGRectGetHeight([self bounds])/2);
        _completion = completion;
        _duration = duration;
        _lineWidth = lineWidth;
        _gradientColors = colors;
        _imageName = imageName;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
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
    
    CGFloat circleStartAngle = (180.0f * M_PI) / 180.0f;
    CGFloat progressCircleEndAngle = (self.count * M_PI) / 180.0f;
    
    CGFloat lineWidth = ((self.frame.size.height / 2) - self.lineWidth);
    
    UIBezierPath *progressCircleAbove = [UIBezierPath bezierPathWithArcCenter:self.position
                                                                       radius:lineWidth
                                                                   startAngle:circleStartAngle
                                                                     endAngle:progressCircleEndAngle
                                                                    clockwise:YES];

    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextAddPath(context, progressCircleAbove.CGPath);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    
    //  Draw a linear gradient from top to bottom
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(self.frame.size.width, 0), 0);
    
    CGContextRestoreGState(context);
    
    UIBezierPath *progressCircleBelow = [UIBezierPath bezierPathWithArcCenter:self.position
                                                                       radius:lineWidth
                                                                   startAngle:-circleStartAngle
                                                                     endAngle:-progressCircleEndAngle
                                                                    clockwise:NO];
    progressCircleBelow.lineWidth = self.lineWidth;

    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextAddPath(context, progressCircleBelow.CGPath);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    
    //  Draw a linear gradient from top to bottom
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(self.frame.size.width, 0), 0);
    
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);

}

- (void)startAnimation
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

- (void)showStepIcon
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
    [imageView.layer setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [imageView setTransform:CGAffineTransformMakeScale(0.01f, 0.01f)];
    
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    
    imageView.frame = CGRectMake(x,
                                 y,
                                 imageView.frame.size.width,
                                 imageView.frame.size.height);
    
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [imageView setTransform:CGAffineTransformMakeScale(1.5f, 1.5f)];
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              [imageView setTransform:CGAffineTransformIdentity];
                                          } completion:nil];
                     }];
}

- (void)updateView
{
    self.count += 6.0f;
    
    if (self.count < 361.0f)
    {
        [self setNeedsDisplay];
    } else {
        [self showStepIcon];
        self.completion(YES);
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
