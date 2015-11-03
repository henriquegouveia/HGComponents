//
//  HGStepsMenu.m
//  BDMStepsMenu
//
//  Created by Henrique Gouveia on 7/2/14.
//  Copyright (c) 2014 Gouveia. All rights reserved.
//

#import "HGStepsMenu.h"
#import "HGProgressCircle.h"
#import "HGProgressLine.h"

@interface HGStepsMenu ()

@property (copy, nonatomic) NSString *stepImageName;
@property (nonatomic) NSInteger steps;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) CGFloat velocity;
@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat xPosition;

@property (copy, nonatomic) UIColor *firstColor;
@property (copy, nonatomic) UIColor *secondColor;
@property (copy, nonatomic) UIColor *thirdColor;
@property (copy, nonatomic) UIColor *forthColor;

@property (copy, nonatomic) NSArray *completedStepsIcons;
@property (copy, nonatomic) NSArray *uncompletedStepsIcons;
@property (copy, nonatomic) NSArray *pendingStepsIcons;

@property (copy, nonatomic) NSArray *skippedSteps;

@property (nonatomic) NSInteger stepCompleted;

@end

@implementation HGStepsMenu

- (void)setSkippedSteps:(NSArray *)skippedSteps
{
    [skippedSteps enumerateObjectsUsingBlock:^(NSNumber *skippedStep, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert(([skippedStep integerValue] <= self.steps), @"Skipped step is greater then available steps.");
    }];
    
    _skippedSteps = skippedSteps;
}

- (void)startStepsCreation
{
    self.xPosition = 0.0f;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self createStepsMenus:0];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSAssert(((self.steps * self.frame.size.height) < self.frame.size.width), @"Some steps won't appear because your width is not enough");
    
    self.steps -= 1;
}

- (void)doneStep:(NSInteger)step withSkippedSteps:(NSArray *)skippedSteps
{
    self.stepCompleted = step;
    
    if (skippedSteps) self.skippedSteps = skippedSteps;
}

- (void)doneStep:(NSInteger)step
{
    [self doneStep:step withSkippedSteps:nil];
}

- (void)setupCompletedIcons:(NSArray *)stepsIcons
{
    self.completedStepsIcons = stepsIcons;
}

- (void)setupUncompletedIcons:(NSArray *)stepsIcons
{
    self.uncompletedStepsIcons = stepsIcons;
}

- (void)setupPendingIcons:(NSArray *)stepsIcons {
    self.pendingStepsIcons = stepsIcons;
}

- (void)createStepsMenus:(NSInteger)step
{
    NSInteger __block currentStep = step;
    
    if (step < self.steps) {
        
        [self createCircleStep:step withCompletionBlock:^(BOOL status) {
            if (status) {
                [self createLineStep:step withCompletionBlock:^(BOOL status) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self createStepsMenus:(currentStep + 1)];
                    });
                }];
            }
        }];
    } else {
        [self createCircleStep:step withCompletionBlock:^(BOOL status) {
            //no completion
        }];
    }
}

- (void)createCircleStep:(NSInteger)step withCompletionBlock:(void(^)(BOOL status))completion
{
    NSString __weak *imageName = [self setupImageForStep:step];

    NSArray *colors = [self setupCircleColorsForNextStep:step];
    
    if ([self.skippedSteps containsObject:@(step)]) {
        colors = @[(id)self.forthColor.CGColor, (id)self.forthColor.CGColor];
    }
    
    HGProgressCircle *circleStep = [[HGProgressCircle alloc] initWithFrame:CGRectMake(self.xPosition,
                                                                                      0.0f,
                                                                                      self.frame.size.height,
                                                                                      self.frame.size.height)
                                                                 lineWidth:self.lineWidth
                                                                 imageName:imageName
                                                                    colors:colors
                                                               forDuration:0.0001
                                                       withCompletionBlock:^(BOOL status) {
                                                           completion(YES);
                                                       }];
    self.xPosition += (circleStep.frame.size.height - self.lineWidth);
    [self addSubview:circleStep];
}

- (void)createLineStep:(NSInteger)step withCompletionBlock:(void(^)(BOOL status))completion
{
    NSArray *colors = [self setupLineColorsForNextStep:step];
    
    if ([self.skippedSteps containsObject:@(step)]) {
        colors = @[(id)self.forthColor.CGColor, colors[1]];
    }
    
    HGProgressLine *lineStep = [[HGProgressLine alloc] initWithFrame:CGRectMake(self.xPosition,
                                                                                0.0f,
                                                                                self.frame.size.height,
                                                                                self.frame.size.height)
                                                           lineWidth:self.lineWidth
                                                               colors:colors
                                                         forDuration:0.0001
                                                            progress:80.0f
                                                 withCompletionBlock:^(BOOL status) {
                                                     completion(YES);
                                                 }];
    self.xPosition += (lineStep.frame.size.height - self.lineWidth);
    [self addSubview:lineStep];
}

- (NSArray *)setupCircleColorsForNextStep:(NSInteger)step
{
    NSArray *colors = nil;
    
    if (step == self.stepCompleted) {
        colors = @[(id)self.secondColor.CGColor, (id)self.secondColor.CGColor];
    } else if (step > self.stepCompleted) {
        colors = @[(id)self.thirdColor.CGColor, (id)self.thirdColor.CGColor];
    } else {
        colors = @[(id)self.firstColor.CGColor, (id)self.firstColor.CGColor];
    }

    return colors;
}

- (NSArray *)setupLineColorsForNextStep:(NSInteger)step
{
    NSArray *colors = nil;
    NSInteger nextStep = (step + 1);
    
    if (nextStep == self.stepCompleted) {
        colors = @[(id)self.firstColor.CGColor, (id)self.secondColor.CGColor];
    } else if (step < self.stepCompleted) {
        colors = @[(id)self.firstColor.CGColor, (id)self.firstColor.CGColor];
    } else if (step > self.stepCompleted) {
        colors = @[(id)self.thirdColor.CGColor, (id)self.thirdColor.CGColor];
    } else {
        colors = @[(id)self.secondColor.CGColor, (id)self.thirdColor.CGColor];
    }

    return colors;
}

- (NSString *)setupImageForStep:(NSInteger)step
{
    if (step == self.stepCompleted) {
        return [self.uncompletedStepsIcons objectAtIndex:step];
    } else if (step > self.stepCompleted) {
        return [self.pendingStepsIcons objectAtIndex:step];
    } else {
        return [self.completedStepsIcons objectAtIndex:step];
    }
}

@end
