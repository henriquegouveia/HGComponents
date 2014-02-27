//
//  QuartzFunctionsProtocol.h
//  HGComponents
//
//  Created by Henrique Gouveia on 2/26/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HGQuartzFunctionsProtocol <NSObject>

- (void)shakeComponent:(id<HGQuartzFunctionsProtocol>)component
                repeat:(NSInteger)repeat
             intensity:(CGFloat)intensity
              duration:(NSTimeInterval)duration;

- (void)roundedSpecificCorners:(UIRectCorner)rectCorner toComponent:(id<HGQuartzFunctionsProtocol>)component withRadius:(CGFloat)radius;

- (void)roundComponentCorners:(id<HGQuartzFunctionsProtocol>)component withRadius:(CGFloat)radius;

@end
