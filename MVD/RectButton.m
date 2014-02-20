//
//  RectButton.m
//  MVD
//
//  Created by Denis Kurochkin on 31.01.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "RectButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation RectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted)
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    else
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.00];
}

- (void) awakeFromNib
{
    self.layer.cornerRadius = 10.0;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
}


@end
