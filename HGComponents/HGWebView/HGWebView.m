//
//  HGWebView.m
//  HGFramework
//
//  Created by Henrique Gouveia on 1/2/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import "HGWebView.h"

@interface HGWebView ()

@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation HGWebView

- (id)initWithFrame:(CGRect)frame address:(NSString *)address
{
    self = [super init];
    if (self)
    {
        NSURL *url = [NSURL URLWithString:address];
        self.request = [NSURLRequest requestWithURL:url];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
