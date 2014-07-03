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
@property (nonatomic) CGFloat xPosition;

@end

@implementation HGStepsMenu

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSAssert((((self.steps * 2) * self.frame.size.height) < self.frame.size.width), @"Some steps won't appear because its width is not enough");
    
    self.lineWidth = 2.0f;
    self.velocity = 0.001f;
    
    self.steps -= 1;
    
    [self createStepsMenus:0];
}

- (void)createStepsMenus:(NSInteger)step
{
    NSInteger __block currentStep = step;
    
    if (step < self.steps) {
        [self createBallStep:step withCompletionBlock:^(BOOL status) {
            if (status) {
                [self createLineStep:step withCompletionBlock:^(BOOL status) {
                    [self createStepsMenus:(currentStep + 1)];
                }];
            }
        }];
    } else {
        [self createBallStep:step withCompletionBlock:^(BOOL status) {
            //no completion
        }];
    }
}

- (void)createBallStep:(NSInteger)step withCompletionBlock:(void(^)(BOOL status))completion
{
    NSString __weak *imageName = [NSString stringWithFormat:@"%@%d", self.stepImageName, step];
    
    HGProgressCircle *circleStep = [[HGProgressCircle alloc] initWithFrame:CGRectMake(self.xPosition,
                                                                                      0.0f,
                                                                                      self.frame.size.height,
                                                                                      self.frame.size.height)
                                                                 lineWidth:self.lineWidth
                                                                 imageName:imageName
                                                                     color:[UIColor blueColor]
                                                               forDuration:self.velocity
                                                       withCompletionBlock:^(BOOL status) {
                                                           completion(YES);
                                                       }];
    self.xPosition += (circleStep.frame.size.height - self.lineWidth);
    [self addSubview:circleStep];
}

- (void)createLineStep:(NSInteger)step withCompletionBlock:(void(^)(BOOL status))completion
{
    HGProgressLine *lineStep = [[HGProgressLine alloc] initWithFrame:CGRectMake(self.xPosition,
                                                                                0.0f,
                                                                                self.frame.size.height,
                                                                                self.frame.size.height)
                                                           lineWidth:self.lineWidth
                                                               color:[UIColor redColor]
                                                         forDuration:self.velocity
                                                 withCompletionBlock:^(BOOL status) {
                                                     completion(YES);
                                                 }];
    self.xPosition += (lineStep.frame.size.height - self.lineWidth);
    [self addSubview:lineStep];
}


@end
