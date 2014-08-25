//
//  HGRingChart.m
//  HGFramework
//
//  Created by Henrique Gouveia on 10/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGRingChart.h"
#import "HGRingChartSlice.h"

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

@property (copy, nonatomic) NSArray *properties;
@property (nonatomic, strong) NSTimer *timer;
@property (copy, nonatomic) NSMutableArray *sliceStacker;

@property (nonatomic) CGFloat lastPercentage;

@end

@implementation HGRingChart

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
          lineWidth:(NSInteger)lineWidth
         properties:(NSArray *)properties
           velocity:(CGFloat)velocity
  animationDuration:(NSTimeInterval)animationDuration
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _backColor = backColor;
        _lineWidth = lineWidth;
        _duration = animationDuration;
        _velocity = velocity;
        _properties = properties;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat percentage = 360.0f * (self.percentage / 100.0f);
    
    CGPoint circlePoint = CGPointMake(CGRectGetWidth([self bounds])/2, CGRectGetHeight([self bounds])/2);
    CGFloat circleRadius = (CGRectGetWidth([self bounds]) - [self lineWidth]) / 2;
    CGFloat circleStartAngle = (-90.0f + percentage) * M_PI / 180.0f;
    CGFloat backCircleEndAngle = 270.0f * M_PI / 180.0f;
    
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:circlePoint
                                                              radius:circleRadius
                                                          startAngle:circleStartAngle
                                                            endAngle:backCircleEndAngle
                                                           clockwise:YES];
    
    [[self backColor] setStroke];
    [backCircle setLineWidth:(CGFloat)[self lineWidth]];
    [backCircle stroke];
}

- (void)startAnimation
{
    [self createSlices:[[NSMutableArray alloc] initWithArray:self.properties copyItems:YES]];
}

- (void)updatePercentage:(NSArray *)properties
{
    [self updateSlices:[[NSMutableArray alloc] initWithArray:properties copyItems:YES]];
}

- (void)updateSlices:(NSMutableArray *)slices
{
    if (!slices.count)
    {
        return;
    }
    
    CGFloat percentage = [[[slices lastObject] objectForKey:@"percentage"] floatValue];
    
    HGRingChartSlice * __weak slice = [self.sliceStacker objectAtIndex:(self.sliceStacker.count - slices.count)];
    [slice updatePercentage:percentage];
    
    [slices removeLastObject];
    [self updateSlices:slices];
}

- (void)createSlices:(NSMutableArray *)slices
{
    if (!slices.count)
    {
        return;
    }
    
    NSDictionary *sliceProperties = [slices lastObject];
    
    NSArray *progressColors = [sliceProperties objectForKey:@"progressColors"];
    CGFloat percentage = [[sliceProperties objectForKey:@"percentage"] floatValue];
    
    CGFloat startAngle = (-90.0f + (360.0f * (self.lastPercentage / 100))) * M_PI / 180.0f;
    
    HGRingChartSlice *slice = [[HGRingChartSlice alloc] initWithFrame:self.bounds
                                                           startAngle:startAngle
                                                       progressColors:progressColors
                                                            lineWidth:self.lineWidth
                                                           percentage:percentage
                                                             velocity:self.velocity
                                                    animationDuration:self.duration
                                                    currentPercentage:^(CGFloat percentage) {
                                                        [self.delegate updatePercentage:percentage];
                                                    } completion:^(BOOL finished, CGFloat percentage) {
                                                        [self.delegate updatePercentage:percentage];
                                                        [self.delegate didFinishAnimation];

                                                        self.lastPercentage += percentage;
                                                        
                                                        [self createSlices:slices];
                                                    }];
    
    [self.sliceStacker addObject:slice];
    
    [slices removeLastObject];
    [self addSubview:slice];
}

- (NSArray *)sliceStacker
{
    if (!_sliceStacker)
    {
        _sliceStacker = [NSMutableArray array];
    }
    
    return _sliceStacker;
}

@end
