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

const NSString *kTitleProperty = @"kTitleProperty";
const NSString *kGradientHorizontalProperty = @"kGradientHorizontalProperty";
const NSString *kGradientVerticalProperty = @"kGradientVerticalProperty";
const NSString *kBackgroundColorProperty = @"kBackgroundColorProperty";
const NSString *kBackgroundImageProperty = @"kBackgroundImageProperty";
const NSString *kBackgroundDisabledImageProperty = @"kBackgroundDisabledImageProperty";
const NSString *kBackgroundSelectedImageProperty = @"kBackgroundSelectedImageProperty";
const NSString *kCornerRadiusProperty = @"kCornerRadiusProperty";
const NSString *kBorderColorProperty = @"kBorderColorProperty";
const NSString *kBorderWidthProperty = @"kBorderWidthProperty";
const NSString *kFontTypeProperty = @"kFontTypeProperty";
const NSString *kFontColorProperty = @"kFontColorProperty";
const NSString *kFontColorWhenSelectedProperty = @"kFontColorWhenSelectedProperty";
const NSString *kShadowColor = @"kShadowColor";
const NSString *kShadowOpaHGy = @"kShadowOpaHGy";
const NSString *kShadowRadius  = @"kShadowRadius";
const NSString *kShadowOffset = @"kShadowOffset";

@interface HGButton ()

@property (strong, nonatomic) UIColor *customBackgroundColor;
@property (assign, nonatomic) CGFloat radius;
@property (assign, nonatomic) CGFloat backgroundAlpha;

@property (nonatomic) CGFloat borderWidth;
@property (weak, nonatomic) UIColor *borderColor;

@end

@implementation HGButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (!_backgroundAlpha)
        _backgroundAlpha = 1.0f;
    
    [self roundComponentCorners:_radius];

    if (_customBackgroundColor)
        [self backgroundColorWithAlpha:_customBackgroundColor alpha:_backgroundAlpha];
    
    [self _setup];
}

- (void)_setup
{
    [self _setupBorder];
}

- (void)_setupBorder
{
    CALayer *layer = [CALayer new];
    
    [layer setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [layer setFrame:CGRectMake(9.0f, 10.0f, (self.radius * 2), (self.radius * 2))];
    
    [layer setBorderWidth:self.borderWidth];
    [layer setBorderColor:self.borderColor.CGColor];
    [layer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.radius];
    
    [self.layer addSublayer:layer];
}

- (id)initWithFrame:(CGRect)frame withProperties:(NSDictionary *)properties
{
    self = [super initWithFrame:frame];
    if (self) {
        [self applyProperties:properties];
    }
    return self;
}

- (void)applyProperties:(NSDictionary *)properties
{
    if (properties[kTitleProperty] != nil) {
        [self title:properties[kTitleProperty]];
    }
    
    if (properties[kGradientHorizontalProperty] != nil) {
        [self gradientHorizontal:properties[kGradientHorizontalProperty]];
    }
    
    if (properties[kGradientVerticalProperty] != nil) {
        [self gradientVertical:properties[kGradientVerticalProperty]];
    }

    if (properties[kBackgroundColorProperty] != nil) {
        [self backgroundColor:properties[kBackgroundColorProperty]];
    }
    
    if (properties[kBackgroundImageProperty] != nil) {
        [self backgroundImage:properties[kBackgroundImageProperty]];
    }
    
    if (properties[kBackgroundDisabledImageProperty] != nil) {
        [self backgroundDisabledImage:properties[kBackgroundDisabledImageProperty]];
    }
    
    if (properties[kBackgroundSelectedImageProperty] != nil) {
        [self backgroundSelectedImage:properties[kBackgroundSelectedImageProperty]];
    }
    
    if (properties[kBorderColorProperty] != nil && properties[kBorderWidthProperty] != nil) {
        [self borderWidth:[properties[kBorderWidthProperty] floatValue] withColor:properties[kBorderColorProperty]];
    }
    
    if (properties[kFontTypeProperty] != nil) {
        [self fontType:properties[kFontTypeProperty]];
    }
    
    if (properties[kFontColorProperty] != nil) {
        [self fontColor:properties[kFontColorProperty]];
    }
    
    if (properties[kFontColorWhenSelectedProperty] != nil) {
        [self fontColorWhenSelected:properties[kFontColorWhenSelectedProperty]];
    }
    
    if (properties[kShadowOffset] != nil) {
        [self shadowOffset:[properties[kShadowOffset] CGSizeValue]];
    }
    
    if (properties[kShadowRadius] != nil) {
        [self shadowRadius:[properties[kShadowRadius] floatValue]];
    }
    
    if (properties[kShadowOpaHGy] != nil) {
        [self shadowOpaHGy:[properties[kShadowOpaHGy] floatValue]];
    }
    
    if (properties[kShadowColor] != nil) {
        [self shadowColor:properties[kShadowColor]];
    }
}

- (void)title:(NSString *)text
{
    [self setTitle:text forState:UIControlStateNormal];
}

- (void)gradientHorizontal:(NSArray *)colors
{    
    [UIColor addGradientHorizontalInView:self withColors:colors];
}

- (void)gradientVertical:(NSArray *)colors
{
    [UIColor addGradientVerticalInView:self withColors:colors];
}

- (void)backgroundColor:(UIColor *)color
{
    [self setBackgroundColor:color];
}

- (void)backgroundColorWithAlpha:(UIColor *)color alpha:(CGFloat)alpha
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    
    UIColor *finalColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    [self setBackgroundColor:finalColor];
}

- (void)backgroundImage:(UIImage *)image
{
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)backgroundDisabledImage:(UIImage *)image
{
    [self setBackgroundImage:image forState:UIControlStateDisabled];
}

- (void)backgroundSelectedImage:(UIImage *)image
{
    [self setBackgroundImage:image forState:UIControlStateSelected];
}

- (void)borderWidth:(CGFloat)width withColor:(UIColor *)color
{
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:[color CGColor]];
}

- (void)fontType:(UIFont *)font
{
    [self.titleLabel setFont:font];
}

- (void)fontColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)fontColorWhenSelected:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void)shadowOffset:(CGSize)size
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = size;
}

- (void)shadowRadius:(CGFloat)radius
{
    self.layer.shadowRadius = radius;
}

- (void)shadowOpaHGy:(CGFloat)opaHGy 
{
    self.layer.shadowOpacity = opaHGy;
}

- (void)shadowColor:(UIColor *)color
{
    self.layer.shadowColor = color.CGColor;
}

- (void)setHighlighted:(BOOL)highlighted
{
    self.alpha = highlighted ? 0.7f : 1.0f;
    [super setHighlighted:highlighted];
}

- (void)setEnabled:(BOOL)enabled
{
    self.alpha = enabled ? 1.0f : 0.5f;
    [super setEnabled:enabled];
}

@end
