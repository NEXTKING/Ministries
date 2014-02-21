//
//  DottedLine.m
//  MVD
//
//  Created by Denis Kurochkin on 21.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "DottedLine.h"

@implementation DottedLine
{
    CAShapeLayer *shapelayer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib
{
    // Important, otherwise we will be adding multiple sub layers
    if ([[[self layer] sublayers] objectAtIndex:0])
    {
        self.layer.sublayers = nil;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setLineWidth:3.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.frame.origin.x, self.frame.origin.y);
    CGPathAddLineToPoint(path, NULL, self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[self layer] addSublayer:shapeLayer];
}

- (void) layoutSubviews
{
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
