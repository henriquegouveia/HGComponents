//
//  UIView+HGAdditionals.h
//  HGComponents
//
//  Created by Henrique Gouveia on 2/27/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HGAdditionals)

- (void)roundedSpecificCorners:(UIRectCorner)rectCorner withRadius:(CGFloat)radius;
- (void)shakeComponentRepeat:(NSInteger)repeat intensity:(CGFloat)intensity duration:(NSTimeInterval)duration;
- (void)roundComponentCorners:(CGFloat)radius;

@end
