//
//  UIColor+CITAdditionals.h
//  CITFramework
//
//  Created by Henrique Gouveia on 12/18/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CITAdditionals)

+ (void)addFadeout:(UIView *)view
        withColors:(NSArray *)colors
        startPoint:(CGPoint)startPoint
          endPoint:(CGPoint)endPoint;

+ (void)addGradientHorizontalInView:(UIView *)view
                         withColors:(NSArray *)colors;

+ (void)addGradientVerticalInView:(UIView *)view
                       withColors:(NSArray *)colors;

@end
