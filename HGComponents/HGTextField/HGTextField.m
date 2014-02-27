//
//  HGTextField.m
//  HGFramework
//
//  Created by Henrique Gouveia on 12/9/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGTextField.h"

#import "HGQuartzFunctionsStrategy.h"

@interface HGTextField () <HGQuartzFunctionsProtocol>

@property (strong, nonatomic) HGQuartzFunctionsStrategy *quartzStrategy;

@property (assign, nonatomic) CGFloat radius;

@end

@implementation HGTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self cornerRadiusCustom:_radius];
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
    _quartzStrategy = [HGQuartzFunctionsStrategy new];
    
    [self _setupCorners];
}

- (void)_setupCorners
{
    if (_radius)
    {
        [_quartzStrategy roundComponentCorners:self withRadius:_radius];
    }
}

@end
