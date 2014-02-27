//
//  UIColor+HGAdditionals.m
//  HGFramework
//
//  Created by Henrique Gouveia on 12/18/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "UIColor+HGAdditionals.h"

@implementation UIColor (HGAdditionals)

+ (void)addFadeout:(UIView *)view
        withColors:(NSArray *)colors
        startPoint:(CGPoint)startPoint
          endPoint:(CGPoint)endPoint
{
    UIColor * someColor = [UIColor colorWithCGColor:((__bridge CGColorRef)[colors lastObject])];
    UIColor * halfClearColor = [someColor colorWithAlphaComponent:0];
    
    CALayer *layer = view.layer;
    layer.masksToBounds = YES;
    
    CAGradientLayer *transparencyLayer = [CAGradientLayer layer];
    transparencyLayer.frame = layer.bounds;
    transparencyLayer.colors = @[(id)someColor.CGColor,
                                 (id)halfClearColor.CGColor];
    transparencyLayer.locations = @[[NSNumber numberWithFloat:0.0f],
                                    [NSNumber numberWithFloat:1.0f]];
    
    if(colors.count)
    {
        CAGradientLayer * multiColoredLayer = [self getMultiColoredLayerWithColors:colors
                                                                        startPoint:startPoint
                                                                        endPoint:endPoint
                                                                        inLayer:layer];
        multiColoredLayer.mask = transparencyLayer;
        [view.layer insertSublayer:multiColoredLayer atIndex:0];
    } else {
        [view.layer insertSublayer:transparencyLayer atIndex:0];
    }
}


+ (CAGradientLayer *)getMultiColoredLayerWithColors:(NSArray *)colors
                                         startPoint:(CGPoint)startPoint
                                           endPoint:(CGPoint)endPoint
                                            inLayer:(CALayer *)layer
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = layer.bounds;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    return gradientLayer;
}

+ (void)addGradientHorizontalInView:(UIView *)view
                         withColors:(NSArray *)colors
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    view.layer.masksToBounds = YES;
    [gradientLayer setBounds:view.bounds];
    [gradientLayer setFrame:view.bounds];
    [gradientLayer setColors:colors];
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

+ (void)addGradientVerticalInView:(UIView *)view
                       withColors:(NSArray *)colors
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    view.layer.masksToBounds = YES;
    [gradientLayer setBounds:view.bounds];
    [gradientLayer setFrame:view.bounds];
    [gradientLayer setColors:colors];
    
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

@end
