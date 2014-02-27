//
//  HGMenu.m
//  HGFramework
//
//  Created by Henrique Gouveia on 10/18/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGMenu.h"

#import <QuartzCore/QuartzCore.h>

@interface HGMenu ()

@property (nonatomic, strong) NSArray *createdMenuItems;

/**
 * Custom Button Properties
 */
@property (nonatomic, assign) UIColor  *fontColorStateNormal;
@property (nonatomic, assign) UIColor  *fontColorStateSelected;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, assign) CGFloat   buttonWidth;

@property (nonatomic, strong) UIView  *selectedIndicatorView;

@property (nonatomic, assign) CGFloat lastButtonPosition;
@property (nonatomic, assign) int     lastCreatedIndex;

@end

@implementation HGMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void) customSelectedIndicatorView:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius width:(CGFloat)width
{
    if (!self.selectedIndicatorView)
        NSLog(@"bla");
        
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
