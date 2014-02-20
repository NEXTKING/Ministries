//
//  RankCell.m
//  MVD
//
//  Created by Denis Kurochkin on 19.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "RankCell.h"

@implementation RankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
