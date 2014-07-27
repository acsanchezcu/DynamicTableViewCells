//
//  DYCObjectCell.m
//  DynamicTableViewCells
//
//  Created by Abel Sánchez Custodio on 25/07/14.
//  Copyright (c) 2014 Abel Sanchez Custodio. All rights reserved.
//

#import "DYCObjectCell.h"


@implementation DYCObjectCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel.text = @"";
    self.descriptionLabel.text = @"";
}

+ (CGFloat)height
{
    return 75.0f;
}

@end
