//
//  HGImageView.m
//  HGComponents
//
//  Created by Henrique Gouveia on 6/2/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import "HGImageView.h"

@interface HGImageView ()

@property (assign) BOOL isCircularImageWithBorder;
@property (weak, nonatomic) UIColor *borderColor;
@property (assign) CGFloat borderWidth;

@end

@implementation HGImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _setup];
}

- (void)_setup
{
    [self roundImageWithBorderColorAndWidth];
}

- (void)roundImageWithBorderColorAndWidth
{
    if (self.isCircularImageWithBorder)
    {
        CGFloat radius = (self.frame.size.width / 2);
        
        [self.layer setCornerRadius:radius];
        [self.layer setMasksToBounds:YES];
    }
    
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:[self.borderColor CGColor]];
}

@end
