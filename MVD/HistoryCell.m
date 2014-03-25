//
//  HistoryCell.m
//  MVD
//
//  Created by Denis Kurochkin on 21.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "HistoryCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation HistoryCell

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
