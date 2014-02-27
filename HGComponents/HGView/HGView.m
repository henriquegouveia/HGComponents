//
//  HGView.m
//  HGFramework
//
//  Created by Henrique Gouveia on 9/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGView.h"

#import "HGQuartzFunctionsStrategy.h"

@interface HGView ()

@property (strong, nonatomic) HGQuartzFunctionsStrategy *quartzStrategy;

@property (assign, nonatomic) BOOL roundTopLeftCorner;
@property (assign, nonatomic) BOOL roundTopRightCorner;
@property (assign, nonatomic) BOOL roundBottomLeftCorner;
@property (assign, nonatomic) BOOL roundBottomRightCorner;
@property (assign, nonatomic) BOOL roundAllCorners;

@property (assign, nonatomic) CGFloat radius;

@end

@implementation HGView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andFlexibleAutoResizing:(UIViewAutoresizing)autoResizing
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutoresizingMask:autoResizing];
    }
    
    return self;
}

#pragma mark - Setup View Properties

- (void)_setup
{
    _quartzStrategy = [HGQuartzFunctionsStrategy new];

    [self _setupRoundedCorners];
}

- (void)_setupRoundedCorners
{
    if (_roundAllCorners)
    {
        [_quartzStrategy roundComponentCorners:self withRadius:_radius]
    } else {
        UIRectCorner corners = [self _setupCheckCorners];
        [_quartzStrategy roundedSpecificCorners:corners
                                    toComponent:self
                                     withRadius:_radius];
    }
}

- (UIRectCorner )_setupCheckCorners
{
    UIRectCorner corners = 0;
    if (_roundTopLeftCorner)
    {
        corners |= UIRectCornerTopLeft;
    }
    
    if (_roundTopRightCorner)
    {
        corners |= UIRectCornerTopRight;
    }
    
    if (_roundBottomLeftCorner)
    {
        corners |= UIRectCornerBottomLeft;
    }
    
    if (_roundBottomRightCorner)
    {
        corners |= UIRectCornerBottomRight;
    }
    
    return corners;
}

#pragma mark - Animations

- (void)addToParentView:(UIView*)parentView withMenuAnimation:(BOOL)status atPoint:(CGPoint)point {
    [self setCenter:point];
    
    CGPoint currentPoint = CGPointMake(self.center.x, self.center.y);
    
    self.center = CGPointMake(self.center.x, (self.center.y - 100));
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [parentView addSubview:self];
    
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = CGPointMake(currentPoint.x, currentPoint.y+11);
        self.transform = CGAffineTransformMakeScale(1.15f, 1.15f);;
    } completion:^(BOOL finished) {
        if (finished)
            [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.center = currentPoint;
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL currentPoint) {
                //no completion
            }];
    }];
}

#pragma mark - Positions

- (void)anchorPoint:(HGViewAnchorPoint)point {
    switch (point) {
        case HGViewAnchorPointUpLeft:
            [[self layer] setAnchorPoint:CGPointMake(0.0f, 0.0f)];
            break;
        case HGViewAnchorPointMiddleLeft:
            [[self layer] setAnchorPoint:CGPointMake(0.5f, 0.0f)];
            break;
        case HGViewAnchorPointDownLeft:
            [[self layer] setAnchorPoint:CGPointMake(1.0f, 0.0f)];
            break;
        case HGViewAnchorPointUpCenter:
            [[self layer] setAnchorPoint:CGPointMake(0.0f, 0.5f)];
            break;
        case HGViewAnchorPointCenter:
            [[self layer] setAnchorPoint:CGPointMake(0.5f, 0.5f)];
            break;
        case HGViewAnchorPointDownCenter:
            [[self layer] setAnchorPoint:CGPointMake(1.0f, 0.5f)];
            break;
        case HGViewAnchorPointUpRight:
            [[self layer] setAnchorPoint:CGPointMake(0.0f, 1.0f)];
            break;
        case HGViewAnchorPointMiddleRight:
            [[self layer] setAnchorPoint:CGPointMake(0.5f, 1.0f)];
            break;
        case HGViewAnchorPointDownRight:
            [[self layer] setAnchorPoint:CGPointMake(1.0f, 1.0f)];
            break;
        default:
            break;
    }
}

#pragma mark - Customizations

- (void)addShadow:(CGFloat)radius withColor:(UIColor *)color opaHGy:(CGFloat)opaHGy offset:(CGFloat)offset {
    [[self layer] setShadowRadius:radius];
    [[self layer] setShadowOpacity:opaHGy];
    [[self layer] setShadowColor:[color CGColor]];
}

@end
