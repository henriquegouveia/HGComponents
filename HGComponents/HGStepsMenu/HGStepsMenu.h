//
//  HGStepsMenu.h
//  BDMStepsMenu
//
//  Created by Henrique Gouveia on 7/2/14.
//  Copyright (c) 2014 Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGStepsMenu : UIView

- (void)setupCompletedIcons:(NSArray *)stepsIcons;
- (void)setupUncompletedIcons:(NSArray *)stepsIcons;
- (void)setupPendingIcons:(NSArray *)stepsIcons;
- (void)doneStep:(NSInteger)step;
- (void)doneStep:(NSInteger)step withSkippedSteps:(NSArray *)skippedSteps;
- (void)startStepsCreation;



@end
