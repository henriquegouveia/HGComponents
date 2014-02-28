//
//  HGDragView.h
//  HGFramework
//
//  Created by Henrique Gouveia on 12/19/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGView.h"

//
//

/* 
 * Notification when drag to left menu with key:  "LeftDragMenuNotification".
 * Notification when drag to right menu with key: "RightDragMenuNotification".
*/

typedef enum
{
    HGDragViewStrategyRightToLeft = 0
}HGDragViewStrategy;

@protocol HGDragViewStrategyProtocol;

@interface HGDragView : HGView

@property (nonatomic, assign) BOOL draggedMenuOpen;
@property (nonatomic) NSString *strategy;
@property (nonatomic) CGFloat peakAmount;
@property (nonatomic) CGFloat maxExtendedAmount;
@property (nonatomic) CGFloat visibleAmount;
@property (nonatomic, strong) id<HGDragViewStrategyProtocol> dragOutViewStrategy;
@property (nonatomic) CGFloat veloHGyAnimation;
@end

@protocol HGDragViewStrategyProtocol <NSObject>

@required

- (CGPoint)pointForDragginView:(HGDragView *)dragginView afterTranslation:(CGPoint)translation;
- (BOOL)isShowingPeakAmountForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view;
- (BOOL)isMaxExtendedAmountReachedForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view;
- (BOOL)isEntireViewShownForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view;
- (BOOL)isShowingMoreThanVisibleAmountForDraggingView:(HGDragView *)draggingView atPoint:(CGPoint)point inView:(UIView *)view;
- (BOOL)shouldShowDraggingView:(HGDragView *)draggingView basedOnVeloHGy:(CGPoint)veloHGy;
- (CGPoint)pointForClosedDraggingView:(HGDragView *)draggingView inView:(UIView *)view;
- (CGPoint)pointForOpenedDraggingView:(HGDragView *)draggingView inView:(UIView *)view;

@end