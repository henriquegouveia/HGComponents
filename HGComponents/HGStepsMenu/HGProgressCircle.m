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
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) HGStepCompletinoBlock completion;

@end

@implementation HGProgressCircle

- (id)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth
          imageName:(NSString *)imageName
              color:(UIColor *)color
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
        _color = color;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self startAnimation];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat circleStartAngle = (180.0f * M_PI) / 180.0f;
    CGFloat progressCircleEndAngle = (self.count * M_PI) / 180.0f;
    
    CGFloat lineWidth = ((self.frame.size.height / 2) - self.lineWidth);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    
    UIBezierPath *progressCircleAbove = [UIBezierPath bezierPathWithArcCenter:self.position
                                                                       radius:lineWidth
                                                                   startAngle:circleStartAngle
                                                                     endAngle:progressCircleEndAngle
                                                                    clockwise:YES];
    
    progressCircleAbove.lineWidth = 2.0f;
    [progressCircleAbove stroke];
    
    UIBezierPath *progressCircleBelow = [UIBezierPath bezierPathWithArcCenter:self.position
                                                                       radius:lineWidth
                                                                   startAngle:-circleStartAngle
                                                                     endAngle:-progressCircleEndAngle
                                                                    clockwise:NO];
    progressCircleBelow.lineWidth = self.lineWidth;
    [progressCircleBelow stroke];
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
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [imageView setTransform:CGAffineTransformMakeScale(1.2f, 1.2f)];
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
    self.count += 1.0f;
    
    if (self.count < 361.0f)
    {
        [self setNeedsDisplay];
    } else {
        self.completion(YES);
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
