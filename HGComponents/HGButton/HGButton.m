//
//  HGButton.m
//  CustomButton
//
//  Created by Salmo Roberto da Silva Junior on 12/12/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "HGButton.h"
#import "UIColor+HGAdditionals.h"
#import "UIView+HGAdditionals.h"

@interface HGButton ()

@property (assign, nonatomic) CGFloat radius;

@property (nonatomic) CGFloat borderWidth;
@property (weak, nonatomic) UIColor *borderColor;

@end

@implementation HGButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _setup];
}

- (void)_setup
{
    [self roundComponentCorners:_radius];
    [self _setupBorder];
}

- (void)_setupBorder
{
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:self.borderColor.CGColor];
}

- (void)gradientHorizontal:(NSArray *)colors
{
    [UIColor addGradientHorizontalInView:self withColors:colors];
}

- (void)gradientVertical:(NSArray *)colors
{
    [UIColor addGradientVerticalInView:self withColors:colors];
}

- (void)setEnabled:(BOOL)enabled
{
    self.alpha = enabled ? 1.0f : 0.5f;
    [super setEnabled:enabled];
}

@end
