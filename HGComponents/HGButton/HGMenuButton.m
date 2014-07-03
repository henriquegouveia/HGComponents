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
            
            self.lineOne.frame = CGRectMake(self.lineOne.frame.origin.x,
                                            self.lineOne.frame.origin.y + self.gapBetweenLines,
                                            (self.lineOne.frame.size.width/3),
                                            self.lineOne.frame.size.height);
            
            self.lineTwo.frame = CGRectMake(self.lineTwo.frame.origin.x,
                                              self.lineTwo.frame.origin.y,
                                              (self.lineTwo.frame.size.width/3*2),
                                              self.lineTwo.frame.size.height);

            
            self.lineThree.frame = CGRectMake(self.lineThree.frame.origin.x,
                                            self.lineThree.frame.origin.y - self.gapBetweenLines,
                                            (self.lineThree.frame.size.width/3),
                                            self.lineThree.frame.size.height);
            
            self.lineOne.transform = CGAffineTransformMakeRotation(-45.0f * M_PI / 180.0f);
            self.lineThree.transform = CGAffineTransformMakeRotation(45.0f * M_PI / 180.0f);
        } completion:^(BOOL finished) {

            [self setUserInteractionEnabled:YES];
        }];
    }
    
    self.isOpen = NO;
}

- (void)animationCloseMenu
{
    if (!self.isOpen) {
        [self setUserInteractionEnabled:NO];
        
        self.lineOne.transform = CGAffineTransformIdentity;
        self.lineThree.transform = CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.18f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.lineOne.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                            _heightLines + 2 * self.gapBetweenLines,
                                            _widthLines,
                                            _heightLines);
            
            self.lineTwo.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                            _heightLines + 4 * self.gapBetweenLines,
                                            _widthLines,
                                            _heightLines);
            
            self.lineThree.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                              _heightLines + 6 * self.gapBetweenLines,
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
    
    _heightLines = self.frame.size.height/20;
    CGFloat percentage = 60.0f/100.0f;
    _widthLines = self.frame.size.width * percentage;
    self.gapBetweenLines = 4;
    
    if (self.isOpen) {
        
    } else {
        
        self.lineOne.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                        _heightLines + 2 * self.gapBetweenLines,
                                        _widthLines,
                                        _heightLines);
        
        self.lineTwo.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                        _heightLines + 4 * self.gapBetweenLines,
                                        _widthLines,
                                        _heightLines);
        
        self.lineThree.frame = CGRectMake((self.frame.size.width - _widthLines)/2,
                                          _heightLines + 6 * self.gapBetweenLines,
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
