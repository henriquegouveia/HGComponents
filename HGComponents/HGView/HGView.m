//
//  HGView.m
//  HGFramework
//
//  Created by Henrique Gouveia on 9/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGView.h"

#import "UIView+HGAdditionals.h"

@interface HGView ()

@property (assign, nonatomic, readonly) BOOL roundTopLeftCorner;
@property (assign, nonatomic, readonly) BOOL roundTopRightCorner;
@property (assign, nonatomic, readonly) BOOL roundBottomLeftCorner;
@property (assign, nonatomic, readonly) BOOL roundBottomRightCorner;
@property (assign, nonatomic, readonly) BOOL roundAllCorners;

@property (assign, nonatomic, readonly) BOOL isMenu;

@property (assign, nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) UIColor *borderColor;

@property (assign, nonatomic) CGFloat radius;

@end

@implementation HGView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _setup];
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
    [self _setupRoundedCorners];
    [self _setupMenuBehavior];
    [self _setupBorder];
}

- (void)_setupMenuBehavior
{
    if (_isMenu)
    {
        self.alpha = 0.1f;
    }
}

- (void)_setupRoundedCorners
{
    if (_roundAllCorners)
    {
        [self roundComponentCorners:_radius];
    } else {
        UIRectCorner corners = [self _setupCheckCorners];
        [self roundedSpecificCorners:corners withRadius:_radius];
    }
}

- (void)_setupBorder
{
    [self.layer setBorderWidth:_borderWidth];
    [self.layer setBorderColor:_borderColor.CGColor];
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

- (void)showWithMenuAnimationByState:(BOOL)isOpened
{
    [self anchorPoint:HGViewAnchorPointUpCenter];

    if (isOpened)
    {
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(1.15f, 1.15f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
            } completion:^(BOOL finisehd) {
                if (finisehd)
                {
                    [self setAlpha:0.1f];
                }
            }];
        }];
    } else {
        self.alpha = 1.0f;
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(1.15f, 1.15f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finisehd) {
                //no completion
            }];
        }];
    }
}

#pragma mark - Positions

- (void)anchorPoint:(HGViewAnchorPoint)point {
    switch (point) {
        case HGViewAnchorPointUpLeft:
            [[self layer] setAnchorPoint:CGPointMake(0.0f, 0.0f)];
            break;
        case HGViewAnchorPointMiddleLeft:
            [[self layer] setAnchorPoint:CGPointMake(0.0f, 0.5f)];
            break;
        case HGViewAnchorPointBottomLeft:
            [[self layer] setAnchorPoint:CGPointMake(0.0f, 1.0f)];
            break;
        case HGViewAnchorPointUpCenter:
            [[self layer] setAnchorPoint:CGPointMake(0.5f, 0.0f)];
            break;
        case HGViewAnchorPointCenter:
            [[self layer] setAnchorPoint:CGPointMake(0.5f, 0.5f)];
            break;
        case HGViewAnchorPointBottomCenter:
            [[self layer] setAnchorPoint:CGPointMake(0.5f, 1.0f)];
            break;
        case HGViewAnchorPointUpRight:
            [[self layer] setAnchorPoint:CGPointMake(1.0f, 0.0f)];
            break;
        case HGViewAnchorPointMiddleRight:
            [[self layer] setAnchorPoint:CGPointMake(1.0f, 0.5f)];
            break;
        case HGViewAnchorPointBottomRight:
            [[self layer] setAnchorPoint:CGPointMake(1.0f, 1.0f)];
            break;
        default:
            break;
    }
}

#pragma mark - Customizations

- (void)addShadow:(CGFloat)radius withColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGFloat)offset {
    [[self layer] setShadowRadius:radius];
    [[self layer] setShadowOpacity:opacity];
    [[self layer] setShadowColor:[color CGColor]];
}

@end
