//
//  HGDragView.m
//  HGFramework
//
//  Created by Henrique Gouveia on 12/19/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGDragView.h"
#import "HGDragViewRightToLeftStrategy.h"
#import <QuartzCore/QuartzCore.h>

#define k_RightDragMenuNotification @"RightDragMenuNotification"
#define k_LeftDragMenuNotification @"LeftDragMenuNotification"

static NSString * const kHGDragOutViewStrategy = @"strategy";

@interface HGDragView ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation HGDragView

@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize peakAmount = _peakAmount;
@synthesize maxExtendedAmount = _maxExtendedAmount;
@synthesize visibleAmount = _visibleAmount;
@synthesize dragOutViewStrategy = _dragOutViewStrategy;
@synthesize veloHGyAnimation = _veloHGyAnimation;

- (void)awakeFromNib
{
    _dragOutViewStrategy = [[NSClassFromString(self.strategy) alloc] init];

    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    [self addGestureRecognizer:_panGestureRecognizer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            }
    return self;
}

- (void)handleDrag:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:self.superview];
        CGPoint newCenter = [self.dragOutViewStrategy pointForDragginView:self afterTranslation:translation];
        
        BOOL isShowingPeakAmount = [self.dragOutViewStrategy isShowingPeakAmountForDraggingView:self atPoint:newCenter inView:self.superview];
        BOOL isMaxExtendedAmountReached = [self.dragOutViewStrategy isMaxExtendedAmountReachedForDraggingView:self atPoint:newCenter inView:self.superview];
        BOOL isEntireViewShown = [self.dragOutViewStrategy isEntireViewShownForDraggingView:self atPoint:newCenter inView:self.superview];
        
        if (isShowingPeakAmount && !isMaxExtendedAmountReached && !isEntireViewShown) {
            self.center = newCenter;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.superview];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGPoint currentVeloHGyPoint = [recognizer velocityInView:self.superview];
        
        BOOL isShowingMoreThanVisibleAmount = [self.dragOutViewStrategy isShowingMoreThanVisibleAmountForDraggingView:self atPoint:self.center inView:self.superview];
        BOOL shouldShowDraggingViewBasedOnVeloHGy = [self.dragOutViewStrategy shouldShowDraggingView:self basedOnVeloHGy:currentVeloHGyPoint];
        
        CGPoint finalPoint;
        
        if (shouldShowDraggingViewBasedOnVeloHGy || isShowingMoreThanVisibleAmount) {
            // open dragging view
            self.draggedMenuOpen = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:k_LeftDragMenuNotification object:self];
            finalPoint = [self.dragOutViewStrategy pointForOpenedDraggingView:self inView:self.superview];
        }
        else {
            // close dragging view
            self.draggedMenuOpen = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:k_RightDragMenuNotification object:self];
            finalPoint = [self.dragOutViewStrategy pointForClosedDraggingView:self inView:self.superview];
        }
        
        [self slideToNewCenter:finalPoint];
    }
}

- (void)slideToNewCenter:(CGPoint)newCenter
{
    [UIView animateWithDuration:_veloHGyAnimation animations:^{
        self.center = newCenter;
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

