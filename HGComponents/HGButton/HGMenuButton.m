//
//  HSNMenuButton.m
//  testCircularView
//
//  Created by Preto on 24/12/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "HGMenuButton.h"
#import <QuartzCore/QuartzCore.h>

@interface HGMenuButton ()

@property (nonatomic) BOOL isOpen;
@property (nonatomic, strong) UIColor *lineColor;


@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UIView *lineThree;

@property (nonatomic, assign) CGRect frameLine;
@property (nonatomic, assign) CGFloat gapBetweenLines;
@property (nonatomic, assign) CGFloat heightLines;
@property (nonatomic, assign) CGFloat widthLines;

@end

@implementation HGMenuButton

- (id)initWithFrame:(CGRect)frame withOpenStatus:(BOOL)isOpen
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isOpen = isOpen;
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    [self clearButtonConfig];
    
    [self drawLines];
    
    if (!_lineColor) {
        self.lineColor = [UIColor whiteColor];
    }
    
    self.isOpen = YES;
}

- (void)clearButtonConfig
{
    self.backgroundColor = [UIColor clearColor];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateSelected];
    [self setTitle:@"" forState:UIControlStateHighlighted];
    [self setTitle:@"" forState:UIControlStateDisabled];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (!highlighted) {
        [self animationMenuButton];
    }
}

- (void)animationMenuButton
{    
    if (self.isOpen) {
        [self animationOpenMenu];
    } else {
        [self animationCloseMenu];
    }
}

- (void)animationOpenMenu
{
    if (self.isOpen) {
        [self setUserInteractionEnabled:NO];
        
        [UIView animateWithDuration:0.18f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.lineOne.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                            _heightLines * 2 + _heightLines/1.5,
                                            _widthLines/2,
                                            _heightLines);
            
            self.lineTwo.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                            _heightLines * 3 + (_heightLines/4),
                                            _widthLines/1.5,
                                            _heightLines);
            
            self.lineThree.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                              _heightLines * 3 + _heightLines/1.2,
                                              _widthLines/2,
                                              _heightLines);
        } completion:^(BOOL finished) {
            self.lineOne.transform = CGAffineTransformMakeRotation(M_PI/-(_widthLines / _heightLines));
            self.lineThree.transform = CGAffineTransformMakeRotation(M_PI/(_widthLines / _heightLines));
            
            [self setUserInteractionEnabled:YES];
        }];
    }
    
    self.isOpen = NO;
}

- (void)animationCloseMenu
{
    if (!self.isOpen) {
        [self setUserInteractionEnabled:NO];
        
        self.lineOne.transform = CGAffineTransformMakeRotation(M_PI);
        self.lineThree.transform = CGAffineTransformMakeRotation(M_PI);
        
        [UIView animateWithDuration:0.18f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.lineOne.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                            _heightLines,
                                            _widthLines,
                                            _heightLines);
            
            self.lineTwo.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                            _heightLines * 3,
                                            _widthLines,
                                            _heightLines);
            
            self.lineThree.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                              _heightLines * 5,
                                              _widthLines,
                                              _heightLines);
        } completion:^(BOOL finished) {
            [self setUserInteractionEnabled:YES];
        }];
    }
    
    self.isOpen = YES;
}

- (void)setLineColor:(UIColor *)lineColor
{
    self.lineOne.backgroundColor = lineColor;
    self.lineTwo.backgroundColor = lineColor;
    self.lineThree.backgroundColor = lineColor;
}

- (void)lineColor:(UIColor *)color
{
    self.lineColor = color;
}

- (void)makeCorner:(NSArray *)views
{
    for (UIView *view in views) {
        view.layer.cornerRadius = view.frame.size.height/2.5;
        [view setClipsToBounds:YES];
    }
}

- (void)drawLines
{
    self.lineOne = [[UIView alloc] init];
    self.lineTwo = [[UIView alloc] init];
    self.lineThree = [[UIView alloc] init];
    
    if (!_heightLines) {
        _heightLines = self.frame.size.height/7;
    }
    
    
    if (!_widthLines) {
        CGFloat percentage = 80.0f/100.0f;
        _widthLines = self.frame.size.width * percentage;
    }
    
    if (self.isOpen) {
        
    } else {
        
        self.lineOne.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                        _heightLines,
                                        _widthLines,
                                        _heightLines);
        
        self.lineTwo.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                        _heightLines * 3,
                                        _widthLines,
                                        _heightLines);
        
        self.lineThree.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                          _heightLines * 5,
                                          _widthLines,
                                          _heightLines);

    }
    
    NSArray *lines = [NSArray arrayWithObjects:self.lineOne, self.lineTwo, self.lineThree, nil];
    [self makeCorner:lines];
    
    [self.lineOne setUserInteractionEnabled:NO];
    [self.lineTwo setUserInteractionEnabled:NO];
    [self.lineThree setUserInteractionEnabled:NO];
    
    [self addSubview:self.lineOne];
    [self addSubview:self.lineTwo];
    [self addSubview:self.lineThree];
}

@end
