//
//  CommonInfoCell.m
//  MVD
//
//  Created by Denis Kurochkin on 22.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "CommonInfoCell.h"

@implementation CommonInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib
{
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:153.0/255.0 blue:157.0/255.0 alpha:1.0];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
