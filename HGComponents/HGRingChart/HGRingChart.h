//
//  HGRingChart.h
//  HGFramework
//
//  Created by Henrique Gouveia on 10/17/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HGRingChartDelegate;

@interface HGRingChart : UIView

@property (nonatomic) id<HGRingChartDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
     progressColors:(NSArray *)progressColors
          lineWidth:(NSInteger)lineWidth
         percentage:(CGFloat)percentage
           velocity:(CGFloat)velocity
  animationDuration:(NSTimeInterval)animationDuration;

//- (void) startAnimation;
- (void)updatePercentage:(CGFloat)percentage;

@end

@protocol HGRingChartDelegate <NSObject>

@optional

- (void) updatePercentage:(CGFloat)percentage;
- (void) didFinishAnimation;

@end
