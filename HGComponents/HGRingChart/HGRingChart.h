//
//  HGRingChart.h
//  HGFramework
//
//  Created by Henrique Gouveia on 10/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HGRingChart;

@interface HGRingChart : UIView

@property (nonatomic, assign) id<HGRingChart> delegate;

- (id) initWithFrame:(CGRect)frame
           backColor:(UIColor *)backColor
       progressColor:(UIColor *)progressColor
           lineWidth:(NSInteger)lineWidth
          percentage:(CGFloat)percentage
   animationDuration:(NSTimeInterval)animationDuration;

- (void) startAnimation;

@end

@protocol HGRingChart <NSObject>

@optional

- (void) updatePercentage:(CGFloat)percentage;
- (void) didFinishAnimation;

@end
