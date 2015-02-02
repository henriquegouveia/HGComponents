//
//  HGTableViewController.h
//  HGFramework
//
//  Created by Henrique Gouveia on 2/12/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HGTableViewControllerDidSelectedItemBlock)(id object);

@interface HGTableViewController : UITableViewController <UITextFieldDelegate>

- (id)initWithDataSource:(NSArray *)dataSource
                 contact:(id)contact
              completion:(HGTableViewControllerDidSelectedItemBlock)block;

@end
