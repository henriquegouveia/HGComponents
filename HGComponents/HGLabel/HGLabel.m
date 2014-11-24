//
//  HGLabel.m
//  HGComponents
//
//  Created by Henrique Cesar Gouveia on 11/24/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import "HGLabel.h"

@interface HGLabel ()

@property (weak, nonatomic) NSString *fontName;
@property (weak, nonatomic) NSNumber *fontSize;

@end

@implementation HGLabel

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
    self.font = [UIFont fontWithName:self.fontName size:self.fontSize.integerValue];
}

- (NSString *)fontName
{
    if (!_fontName) {
        return @"Helvetica";
    }
    
    return _fontName;
}

- (NSNumber *)fontSize {
    
    if (!_fontSize) {
        return @17.0f;
    }
    
    return _fontSize;
}


@end
