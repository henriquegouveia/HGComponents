//
//  HGTableViewController.m
//  HGFramework
//
//  Created by Henrique Gouveia on 2/12/14.
//  Copyright (c) 2014 Henrique Gouveia. All rights reserved.
//

#import "HGTableViewController.h"

@interface HGTableViewController ()

@property (strong, nonatomic) NSArray *paramsToFilter;
@property (strong, nonatomic) NSArray *paramsToShowText;

@property (copy, nonatomic) UITextField *textField;
@property (copy, nonatomic) NSArray *dataSource;
@property (copy, nonatomic) NSArray *searchResult;

@property (copy, nonatomic) UIFont *textFont;
@property (copy, nonatomic) UIColor *textColor;

@property (copy, nonatomic) HGTableViewControllerDidSelectedItemBlock didSelectedObject;

@end

@implementation HGTableViewController

- (id)initWithDataSource:(NSArray *)dataSource
            paramsToShow:(NSArray *)paramsText
          paramsToFilter:(NSArray *)paramsFilter
        textField:(UITextField *)textField
                   frame:(CGRect)rect
                textFont:(UIFont *)font
               textColor:(UIColor *)color
              completion:(HGTableViewControllerDidSelectedItemBlock)block
{
    self = [super init];
    if (self)
    {
        [self.view setFrame:rect];
        
        _dataSource = dataSource;
        _searchResult = dataSource;
        
        _textFont = font;
        _textColor = color;
        
        _paramsToFilter = paramsFilter;
        _paramsToShowText = paramsText;

        _textField = textField;
        _textField.delegate = self;
        
        _didSelectedObject = block;
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        self.tableView.dataSource = self;
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self searchResult] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    id object = [[self searchResult] objectAtIndex:indexPath.row];
    
    NSString *textToShow = [NSString new];
    for (NSString *text in self.paramsToShowText)
    {
        textToShow = [textToShow stringByAppendingFormat:@"%@ ", [object valueForKeyPath:text]];
    }
    
    if (self.textFont)
    {
        [cell.textLabel setFont:self.textFont];
    }
    
    if (self.textColor)
    {
        [cell.textLabel setTextColor:self.textColor];
    }
    
    cell.textLabel.text = textToShow;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.didSelectedObject([self.searchResult objectAtIndex:indexPath.row]);
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.searchResult = [self filterDatasourceParameters:[NSString stringWithFormat:@"%@%@", textField.text, string]];
    [self.tableView reloadData];
    
    return YES;
}

#pragma mark - Filter DataSource Array

- (NSArray *)filterDatasourceParameters:(NSString *)value
{
    NSMutableArray *predicates = [NSMutableArray new];
    
    for (NSString *param in self.paramsToFilter)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", param, value];
        [predicates addObject:predicate];
    }
    
    NSPredicate *compoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
    NSArray *searchResult = [self.dataSource filteredArrayUsingPredicate:compoundPredicate];
    
    return searchResult;
}

@end
