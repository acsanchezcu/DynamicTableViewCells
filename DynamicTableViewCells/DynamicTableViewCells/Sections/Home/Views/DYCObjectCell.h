//
//  DYCObjectCell.h
//  DynamicTableViewCells
//
//  Created by Abel Sánchez Custodio on 25/07/14.
//  Copyright (c) 2014 Abel Sanchez Custodio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DYCObjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

+ (CGFloat)height;

@end
