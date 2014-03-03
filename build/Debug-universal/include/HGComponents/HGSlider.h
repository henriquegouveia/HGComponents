//
//  HGSlider.h
//  DynamicComponents
//
//  Created by Henrique Gouveia on 9/12/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HGSliderDelegate;

/*
 */
@interface HGSlider : UIView

@property (nonatomic, strong) id<HGSliderDelegate> delegate;

//Initialization
- (id)initWithFrame:(CGRect)rect showingBubble:(BOOL)show;

//Methods
- (void)customizeThumbWithColor:(UIColor*)color orImage:(UIImage *)image forControlState:(UIControlState)controlState;

- (void)customizeMaximumValue:(CGFloat)maximumValue withImage:(UIImage *)image;

- (void)customizeMinimumValue:(CGFloat)minimumValue withImage:(UIImage *)image;

@end

@protocol HGSliderDelegate <NSObject>

@required
- (void) didStopMoveFinished:(CGFloat)value;

@end
