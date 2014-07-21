//
//  HGProgressLine.h
//  BDMStepsMenu
//
//  Created by Henrique Gouveia on 7/2/14.
//  Copyright (c) 2014 Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGStepCompletinoBlock.h"

@interface HGProgressLine : UIView

- (id)initWithFrame:(CGRect)frame
          lineWidth:(CGFloat)lineWidth
              colors:(NSArray *)colors
        forDuration:(CGFloat)duration
           progress:(CGFloat)progress
withCompletionBlock:(HGStepCompletinoBlock)completion;

@end
