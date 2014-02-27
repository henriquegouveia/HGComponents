//
//  HGSlider.m
//  DynamicComponents
//
//  Created by Henrique Gouveia on 9/12/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGSlider.h"

#define kBubbleXPosition self.frame.size.width/2
#define kBubbleYPosition -30.0f
#define kBubbleWidth 30.0f
#define kBubbleHeight 20.0f

@interface HGSlider ()

@property (nonatomic, strong) UISlider *mySlider;
@property (nonatomic, weak) UIView *bubbleTrackView;

//Will return the selected value
- (IBAction)didStopMove:(id)sender;

@end

@implementation HGSlider

- (id)initWithFrame:(CGRect)rect showingBubble:(BOOL)show
{
    self = [super initWithFrame:rect];
    
    if (self) {
        [[self bubbleTrackView] setHidden:show];
        [self setMySlider:[[UISlider alloc] initWithFrame:rect]];
        [self setBubbleTrackView:[[UIView alloc] initWithFrame:CGRectMake(kBubbleXPosition, kBubbleYPosition, kBubbleWidth, kBubbleHeight)]];
        
        [self addSubview:[self mySlider]];
        [self addSubview:[self bubbleTrackView]];
    }
    
    return self;
}

#pragma mark - Actions

- (IBAction)didStopMove:(id)sender
{
    [[self delegate] didStopMoveFinished:self.mySlider.value];
}

#pragma mark - Public Instance Methods

- (void)customizeThumbWithColor:(UIColor *)color orImage:(UIImage *)image forControlState:(UIControlState)controlState
{
    if (color) {
        [[self mySlider] setThumbTintColor:color];
    } else if (image) {
        [[self mySlider] setThumbImage:image forState:controlState];
    }
}

- (void)customizeMinimumValue:(CGFloat)minimumValue withImage:(UIImage *)image
{
    [[self mySlider] setMinimumValue:minimumValue];
    
    if (image) {
        [[self mySlider] setMinimumValueImage:image];
    }
}

- (void)customizeMaximumValue:(CGFloat)maximumValue withImage:(UIImage *)image
{
    [[self mySlider] setMaximumValue:maximumValue];
    
    if (image) {
        [[self mySlider] setMaximumValueImage:image];
    }
}

@end
