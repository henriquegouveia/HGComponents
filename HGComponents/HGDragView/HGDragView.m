//
//  HGDragView.m
//  HGFramework
//
//  Created by Henrique Gouveia on 12/19/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGDragView.h"

#import "EHDragOutViewBottomToTopStrategy.h"
#import "EHDragOutViewLeftToRightStrategy.h"
#import "EHDragOutViewRightToLeftStrategy.h"
#import "EHDragOutViewTopToBottomStrategy.h"

#import <QuartzCore/QuartzCore.h>

#define k_RightDragMenuNotification @"RightDragMenuNotification"
#define k_LeftDragMenuNotification @"LeftDragMenuNotification"

static NSString * const kHGDragOutViewStrategy = @"strategy";

@interface HGDragView ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation HGDragView

- (void)awakeFromNib
{
    NSString *classStrategy = [NSString stringWithFormat:@"EHDragOutView%@Strategy", _strategy];

    self.dragOutViewStrategy = [[NSClassFromString(classStrategy) alloc] init];
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
        CGPoint currentVelocityPoint = [recognizer velocityInView:self.superview];
        
        BOOL isShowingMoreThanVisibleAmount = [self.dragOutViewStrategy isShowingMoreThanVisibleAmountForDraggingView:self atPoint:self.center inView:self.superview];
        BOOL shouldShowDraggingViewBasedOnVelocity = [self.dragOutViewStrategy shouldShowDraggingView:self basedOnVelocity:currentVelocityPoint];
        
        CGPoint finalPoint;
        
        if (shouldShowDraggingViewBasedOnVelocity || isShowingMoreThanVisibleAmount) {
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
    [UIView animateWithDuration:_velocityAnimation animations:^{
        self.center = newCenter;
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

