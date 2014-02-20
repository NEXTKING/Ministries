//
//  HumanCell.m
//  MVD
//
//  Created by Denis Kurochkin on 12.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "HumanCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation HumanCell

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
    bgColorView.backgroundColor = [UIColor lightGrayColor];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
