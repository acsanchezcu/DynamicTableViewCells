//
//  DYCHomeViewController.m
//  DynamicTableViewCells
//
//  Created by Abel Sánchez Custodio on 25/07/14.
//  Copyright (c) 2014 Abel Sanchez Custodio. All rights reserved.
//

#import "DYCHomeViewController.h"

#import "DYCObject.h"
#import "DYCObjectCell.h"
#import "DYCHomePresenter.h"


static NSString * const CellId = @"ObjectCell";


@interface DYCHomeViewController ()
<UITableViewDataSource, UITableViewDelegate, DYCHomePresenterProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *objets;
@property (retain, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) DYCHomePresenter *presenter;
	
@end

@implementation DYCHomeViewController

#pragma mark - Init 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _presenter = [[DYCHomePresenter alloc] initWithViewController:self];
    
    [self initialize];
}

#pragma mark - Actions

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [self.presenter userDidRefresh];
}

#pragma mark - Private Methods

- (void)initialize
{
    [self initializeTableView];
    
    [self.presenter viewIsReady];
}

- (void)initializeTableView
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor orangeColor];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.refreshControl];
    [self.tableView sendSubviewToBack:self.refreshControl];
}

- (NSArray *)generateObjects:(NSUInteger)numberOfObjects
{
    NSMutableArray *mutableObjects = [NSMutableArray array];
    
    for (int i = 0; i < numberOfObjects; i++)
    {
        DYCObject *object = [[DYCObject alloc] init];
        
        int lines = arc4random() % 5;
        
        NSString *linesString;
        
        if (lines > 0)
        {
            linesString = @"lines";
        }
        else
        {
            linesString = @"line";
        }
        
        object.objectTitle = [NSString stringWithFormat:@"Object with %d %@", lines + 1, linesString];
        object.objectDescription = [self stringType:lines];
        
        [mutableObjects addObject:object];
    }
    
    return mutableObjects;
}

- (NSString *)stringType:(NSUInteger)type
{
    switch (type)
    {
        case 0:
            return NSLocalizedString(@"text_one_line", nil);
        case 1:
            return NSLocalizedString(@"text_two_lines", nil);
        case 2:
            return NSLocalizedString(@"text_three_lines", nil);
        case 3:
            return NSLocalizedString(@"text_four_lines", nil);
        case 4:
            return NSLocalizedString(@"text_five_lines", nil);
    }
    
    return nil;
}

#pragma mark - PROTOCOLS AND DELEGATES

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYCObjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];

    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(DYCObjectCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYCObject *object = self.objets[indexPath.row];
    
    cell.titleLabel.text = object.objectTitle;
    cell.descriptionLabel.text = object.objectDescription;
    
    [cell layoutIfNeeded];

    [cell.descriptionLabel sizeToFit];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYCObjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    if (height < [DYCObjectCell height])
    {
        height = [DYCObjectCell height];
    }
    
    return height;
}

#pragma mark - DYCHomePresenterProtocol

- (void)printData:(NSArray *)objects
{
    if (self.refreshControl.isRefreshing)
    {
        [self.refreshControl endRefreshing];
    }
    
    self.objets = objects;
    
    [self.tableView reloadData];
}

@end
