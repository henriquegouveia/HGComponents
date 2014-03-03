//
//  HGButton.h
//  CustomButton
//
//  Created by Salmo Roberto da Silva Junior on 12/12/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kTitleProperty;                        // NSString
extern NSString *kGradientHorizontalProperty;           // NSArray of CGColor
extern NSString *kGradientVerticalProperty;             // NSArray of CGColor
extern NSString *kBackgroundColorProperty;              // UIColor
extern NSString *kBackgroundImageProperty;              // UIImage
extern NSString *kBackgroundDisabledImageProperty;      // UIImage
extern NSString *kBackgroundSelectedImageProperty;      // UIImage
extern NSString *kCornerRadiusProperty;                 // CGFloat
extern NSString *kBorderColorProperty;                  // UIColor
extern NSString *kBorderWidthProperty;                  // CGFloat
extern NSString *kFontTypeProperty;                     // UIFont
extern NSString *kFontColorProperty;                    // UIColor
extern NSString *kFontColorWhenSelectedProperty;        // UIColor
extern NSString *kShadowColor;                          // UIColor
extern NSString *kShadowOpaHGy;                        // CGFLoat
extern NSString *kShadowRadius;                         // CGFloat
extern NSString *kShadowOffset;                         // CGSize

@interface HGButton : UIButton

- (id)initWithFrame:(CGRect)frame withProperties:(NSDictionary *)properties;
- (void)applyProperties:(NSDictionary *)properties;

@end
