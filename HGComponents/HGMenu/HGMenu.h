//
//  HGMenu.h
//  HGFramework
//
//  Created by Henrique Gouveia on 10/18/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HGMenuDelegate;

@interface HGMenu : UIView

@property (nonatomic, assign) id<HGMenuDelegate> delegate;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray*)items;

@end

@protocol HGMenuDelegate <NSObject>

@optional
- (void) selectedItem:(NSInteger)index;

@end
