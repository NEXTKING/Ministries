//
//  CommonButtonContainer.m
//  MVD
//
//  Created by Denis Kurochkin on 13.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "CommonButtonContainer.h"

@implementation CommonButtonContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) awakeFromNib
{
    self.layer.borderColor = [UIColor colorWithRed:0 green:84.0/255.0 blue:100.0/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 10.0f;
}

@end
