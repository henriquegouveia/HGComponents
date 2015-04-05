//
//  HGLabel.m
//  HGComponents
//
//  Created by Henrique Cesar Gouveia on 11/24/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import "HGLabel.h"

IB_DESIGNABLE

@interface HGLabel ()

@property (weak, nonatomic) NSString *fontName;
@property (weak, nonatomic) NSNumber *fontSize;

@property (nonatomic) IBInspectable BOOL highQuality;

@end

@implementation HGLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _setup];
}

+ (Class)layerClass {
    return [CATiledLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Setup Component Properties

- (void)_setup {
    if (self.fontName) {
        self.font = [UIFont fontWithName:self.fontName size:self.fontSize.integerValue];
    }
    
    [self setupQuality];
}

- (void)setupQuality {
    if (self.highQuality) {
        CATiledLayer *tiledLayer = (CATiledLayer*)self.layer;
        tiledLayer.levelsOfDetail = 10;
        tiledLayer.levelsOfDetailBias = 10;
    }
}

- (NSNumber *)fontSize {
    if (!_fontSize) {
        return @17.0f;
    }
    
    return _fontSize;
}


@end
