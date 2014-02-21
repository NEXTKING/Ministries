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
    //self.imageView.layer.cornerRadius = self.frame.size.width/2;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
