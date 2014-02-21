//
//  CounterComponentView.m
//  MVD
//
//  Created by Denis Kurochkin on 13.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "CounterComponentView.h"

@implementation CounterComponentView

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
    self.layer.borderColor = [UIColor colorWithRed:0 green:84.0/255.0 blue:100.0/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1;
   
    [super drawRect:rect];
}

- (void) awakeFromNib
{
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Create a colour space:
    //152 174 180
    //105 144 152
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    //Now create the gradient:
    
    size_t gradientNumberOfLocations = 2;
    CGFloat gradientLocations[2] = { 0.0, 1.0 };
    CGFloat gradientComponents[8] = { 152.0/255.0, 174.0/255.0, 180.0/255.0, 1.0,     // Start color
        105.0/255.0, 144.0/255.0, 152.0/255.0, 1.0 };  // End color
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents (colorspace, gradientComponents, gradientLocations, gradientNumberOfLocations);
    //Fill the context with the gradient - this assumes a vertical gradient:
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    //Now you can create an image from the context:
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //Finally release the gradient, colour space and context:
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    UIColor *color = [[UIColor alloc] initWithPatternImage:image];
    self.backgroundColor = color;
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
