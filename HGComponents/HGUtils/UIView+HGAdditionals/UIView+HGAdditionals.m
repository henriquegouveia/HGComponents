//
//  UIView+HGAdditionals.m
//  HGComponents
//
//  Created by Henrique Gouveia on 2/27/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import "UIView+HGAdditionals.h"

@implementation UIView (HGAdditionals)

- (void)roundedSpecificCorners:(UIRectCorner)rectCorner withRadius:(CGFloat)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    [self.layer setMask:maskLayer];
}

- (void)shakeComponentRepeat:(NSInteger)repeat intensity:(CGFloat)intensity duration:(NSTimeInterval)duration
{
    CAKeyframeAnimation * anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"] ;
    anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-intensity, 0.0f, 0.0f)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(intensity, 0.0f, 0.0f)]] ;
    anim.autoreverses = YES ;
    anim.repeatCount = repeat ;
    anim.duration = duration ;
    
    [[self layer] addAnimation:anim forKey:nil ] ;
}

- (void)roundComponentCorners:(CGFloat)radius
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}


@end
