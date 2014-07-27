//
//  DYCHomePresenter.m
//  DynamicTableViewCells
//
//  Created by Abel Sánchez Custodio on 26/07/14.
//  Copyright (c) 2014 Abel Sanchez Custodio. All rights reserved.
//

#import "DYCHomePresenter.h"

#import "DYCHomeViewController.h"
#import "DYCObject.h"


@interface DYCHomePresenter ()

@property (weak, nonatomic) DYCHomeViewController<DYCHomePresenterProtocol> *viewController;

@end


@implementation DYCHomePresenter

#pragma mark - Init

- (id)initWithViewController:(DYCHomeViewController<DYCHomePresenterProtocol> *)viewController
{
    self = [super init];
    
    if (self)
	{
        _viewController = viewController;
    }
    return self;
}

#pragma mark - Public Methods

- (void)viewIsReady
{
    [self.viewController printData:[self generateObjects]];
}

- (void)userDidRefresh
{
    [self.viewController printData:[self generateObjects]];
}

#pragma mark - Private Methods

- (NSUInteger)numberOfObjects
{
    return (arc4random() % 10) + 30;
}

- (NSArray *)generateObjects
{
    int numberOfObjects = [self numberOfObjects];
    
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

@end
