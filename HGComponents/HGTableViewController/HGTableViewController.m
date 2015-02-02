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

@property (copy, nonatomic) NSArray *dataSource;
@property (copy, nonatomic) NSArray *searchResult;
@property (strong, nonatomic)id contact;

@property (copy, nonatomic) HGTableViewControllerDidSelectedItemBlock didSelectedObject;

@end

@implementation HGTableViewController

- (id)initWithDataSource:(NSArray *)dataSource
                 contact:(id)contact
              completion:(HGTableViewControllerDidSelectedItemBlock)block {
    self = [super init];
    
    if (self) {
        _dataSource = dataSource;
        _searchResult = dataSource;
        _didSelectedObject = block;
        _contact = contact;
        
        self.tableView.dataSource = self;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    NSIndexPath *indexPath;
    
    if (self.contact) {
        indexPath= [NSIndexPath indexPathForRow:[self.dataSource indexOfObject:self.contact] inSection:0];
    } else {
        indexPath= [NSIndexPath indexPathForRow:0 inSection:0];
    }

    [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    self.didSelectedObject([self.searchResult objectAtIndex:indexPath.row]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HSNContactsCell" bundle:nil]
         forCellReuseIdentifier:@"Cell"];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self searchResult] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.didSelectedObject([self.searchResult objectAtIndex:indexPath.row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.0f;
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.searchResult = [self filterDatasourceParameters:[NSString stringWithFormat:@"%@%@", textField.text, string]];
    [self.tableView reloadData];

    return YES;
}

#pragma mark - Filter DataSource Array

- (NSArray *)filterDatasourceParameters:(NSString *)value {
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