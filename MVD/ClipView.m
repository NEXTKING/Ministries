//
//  ClipView.m
//  MVD
//
//  Created by Denis Kurochkin on 19.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "ClipView.h"

@implementation ClipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
}

- (void) awakeFromNib
{
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(68, 0, 185, 285);
    [self addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = YES;
    
    
}

- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return _scrollView;
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
