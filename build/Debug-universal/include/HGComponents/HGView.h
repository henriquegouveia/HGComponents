//
//  HGView.h
//  HGFramework
//
//  Created by Henrique Gouveia on 9/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HGViewAnchorPointUpLeft = 0,
    HGViewAnchorPointMiddleLeft,
    HGViewAnchorPointDownLeft,
    HGViewAnchorPointUpCenter,
    HGViewAnchorPointCenter,
    HGViewAnchorPointDownCenter,
    HGViewAnchorPointUpRight,
    HGViewAnchorPointMiddleRight,
    HGViewAnchorPointDownRight
}HGViewAnchorPoint;

@interface HGView : UIView

- (id)initWithFrame:(CGRect)frame andFlexibleAutoResizing:(UIViewAutoresizing)autoResizing;

- (void)addToParentView:(UIView*)parentView withMenuAnimation:(BOOL)status atPoint:(CGPoint)point;

- (void)addShadow:(CGFloat)radius withColor:(UIColor *)color opaHGy:(CGFloat)opaHGy offset:(CGFloat)offset;

- (void)anchorPoint:(HGViewAnchorPoint)point;

@end
