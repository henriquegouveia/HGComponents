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
    HGViewAnchorPointBottomLeft,
    HGViewAnchorPointUpCenter,
    HGViewAnchorPointCenter,
    HGViewAnchorPointBottomCenter,
    HGViewAnchorPointUpRight,
    HGViewAnchorPointMiddleRight,
    HGViewAnchorPointBottomRight
}HGViewAnchorPoint;

@interface HGView : UIView

- (id)initWithFrame:(CGRect)frame andFlexibleAutoResizing:(UIViewAutoresizing)autoResizing;

- (void)showWithMenuAnimationByState:(BOOL)isOpened;

- (void)addShadow:(CGFloat)radius withColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGFloat)offset;

- (void)anchorPoint:(HGViewAnchorPoint)point;

@end
