//
//  InfiniteScrollView.m
//  MVD
//
//  Created by Denis Kurochkin on 22.05.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "InfiniteScrollView.h"

@implementation InfiniteScrollView

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

- (void) changeIfNeeded
{
    if (self.contentOffset.x < 320)
    {
        CGFloat deltaOffset = abs(320 - self.contentOffset.x);
        CGFloat requiredOffset = self.contentSize.width - self.frame.size.width - deltaOffset;
        [self setContentOffset:CGPointMake(requiredOffset, 0)];
    }
    else if (self.contentOffset.x > self.contentSize.width - self.frame.size.width)
    {
        CGFloat deltaOffset = abs (self.contentOffset.x - (self.contentSize.width - self.frame.size.width ));
        CGFloat requiredOffset = 320 + deltaOffset;
        [self setContentOffset:CGPointMake(requiredOffset, 0)];
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [self changeIfNeeded];
    
}

@end
