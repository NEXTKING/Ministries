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

/*
+----------------------------+
|A                           |
|+--------+   +------------+ |
||B       |   |C           | |
||        |   |+----------+| |
|+--------+   ||D         || |
|             |+----------+| |
|             +------------+ |
+----------------------------+
 
*/

- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    
    //if touch is produced outside the _scrollview we should transfer the control to _scrollview. Otherwise going with regular way (super).
    
    if ([self pointInside:point withEvent:event] && (point.x < (320-185)/2 || point.x > 185 + (320-185)/2)) {
        return _scrollView;
    }
    else
       return  [super hitTest:point withEvent:event];
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
