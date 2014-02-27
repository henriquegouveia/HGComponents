//
//  HGDragViewRightToLeftStrategy.m
//  HGFramework
//
//  Created by Henrique Gouveia on 12/19/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGDragViewRightToLeftStrategy.h"

@implementation HGDragViewRightToLeftStrategy

- (CGPoint)pointForDragginView:(HGDragView *)dragginView afterTranslation:(CGPoint)translation
{
    CGPoint point = dragginView.center;
    point.x += translation.x;
    return point;
}

- (BOOL)isShowingPeakAmountForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view
{
    return point.x - draggingView.bounds.size.width * 0.5 + draggingView.peakAmount < view.bounds.size.width;
}
- (BOOL)isMaxExtendedAmountReachedForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view
{
    return point.x - draggingView.bounds.size.width * 0.5 + draggingView.maxExtendedAmount < view.bounds.size.width;
}

- (BOOL)isEntireViewShownForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view
{
    return point.x + draggingView.bounds.size.width * 0.5 < view.bounds.size.width;
}

- (BOOL)isShowingMoreThanVisibleAmountForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view
{
    return draggingView.center.x - draggingView.bounds.size.width * 0.5 + draggingView.visibleAmount < view.bounds.size.width;
}

- (BOOL)shouldShowDraggingView:(HGDragView *)draggingView basedOnVeloHGy:(CGPoint)veloHGy
{
    return veloHGy.x < 100;
}

- (CGPoint)pointForClosedDraggingView:(HGDragView *)draggingView inView:(UIView *)view
{
    CGPoint point = draggingView.center;
    point.x = view.bounds.size.width - draggingView.peakAmount + draggingView.bounds.size.width * 0.5;
    return point;
}

- (CGPoint)pointForOpenedDraggingView:(HGDragView *)draggingView inView:(UIView *)view
{
    CGPoint point = draggingView.center;
    point.x = view.bounds.size.width - draggingView.visibleAmount + draggingView.bounds.size.width * 0.5;
    
    return point;
}

@end
