//
//  DYCHomePresenter.h
//  DynamicTableViewCells
//
//  Created by Abel Sánchez Custodio on 26/07/14.
//  Copyright (c) 2014 Abel Sanchez Custodio. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DYCHomeViewController;


@protocol DYCHomePresenterProtocol <NSObject>

- (void)printData:(NSArray *)objects;

@end


@interface DYCHomePresenter : NSObject

- (id)initWithViewController:(DYCHomeViewController<DYCHomePresenterProtocol> *)viewController;

- (void)viewIsReady;
- (void)userDidRefresh;

@end
