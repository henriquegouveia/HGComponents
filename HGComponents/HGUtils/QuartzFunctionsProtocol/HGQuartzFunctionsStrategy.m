//
//  HGQuartzFunctionsStrategy.m
//  HGComponents
//
//  Created by Henrique Gouveia on 2/26/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import "HGQuartzFunctionsStrategy.h"

@implementation HGQuartzFunctionsStrategy

- (void)roundedSpecificCorners:(UIRectCorner)rectCorner
                   toComponent:(id<HGQuartzFunctionsProtocol>)component
                    withRadius:(CGFloat)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = component.bounds;
    maskLayer.path = maskPath.CGPath;
    
    [self.layer setMask:maskLayer];
}

- (void)shakeComponent:(id<HGQuartzFunctionsProtocol>)component
                repeat:(NSInteger)repeat
             intensity:(CGFloat)intensity
              duration:(NSTimeInterval)duration
{
    CAKeyframeAnimation * anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"] ;
    anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-intensity, 0.0f, 0.0f)],
                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(intensity, 0.0f, 0.0f)]] ;
    anim.autoreverses = YES ;
    anim.repeatCount = repeat ;
    anim.duration = duration ;
    
    [[component layer] addAnimation:anim forKey:nil ] ;
}

- (void)roundComponentCorners:(id<HGQuartzFunctionsProtocol>)component withRadius:(CGFloat)radius
{
    [component.layer setMasksToBounds:YES];
    [component.layer setCornerRadius:radius];
}

@end
