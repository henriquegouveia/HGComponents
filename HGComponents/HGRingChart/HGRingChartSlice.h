//
//  HGRingChartSlice.h
//
//  Created by Henrique Gouveia on 8/22/14.
//  Copyright (c) 2014 Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RingChartUpdateValueCompletionBlock)(CGFloat percentage);
typedef void (^RingChartSliceCompletionBlock)(BOOL finished);

@interface HGRingChartSlice : UIView

- (id)initWithFrame:(CGRect)frame
         startAngle:(CGFloat)angle
     progressColors:(NSArray *)progressColors
          lineWidth:(NSInteger)lineWidth
         percentage:(CGFloat)percentage
           velocity:(CGFloat)velocity
  animationDuration:(NSTimeInterval)animationDuration
  currentPercentage:(RingChartUpdateValueCompletionBlock)percentageBlock
         completion:(RingChartSliceCompletionBlock)completionBlock;

- (void)updatePercentage:(CGFloat)percentage;

@end
