//
//  HGTextField.m
//  HGFramework
//
//  Created by Henrique Gouveia on 12/9/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGTextField.h"

#import "UIView+HGAdditionals.h"

@interface HGTextField ()

@property (assign, nonatomic) CGFloat radius;

@end

@implementation HGTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Setup Component Properties

- (void)_setup
{
    [self _setupCorners];
}

- (void)_setupCorners
{
    if (_radius)
    {
        [self roundComponentCorners:_radius];
    }
}

@end
