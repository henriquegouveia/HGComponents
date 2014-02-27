//
//  HGTableViewCell.m
//  HGFramework
//
//  Created by Henrique Gouveia on 10/18/13.
//  Copyright (c) 2013 Henrique Gouveia. All rights reserved.
//

#import "HGTableViewCell.h"

@implementation HGTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
