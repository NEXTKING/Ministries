//
//  CounterComponentView.m
//  MVD
//
//  Created by Denis Kurochkin on 13.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "CounterComponentView.h"

static double __componentVelocity = 0.05;

@implementation CounterComponentView
{
    NSUInteger currentIterations;
    UILabel *upperLabel;
    BOOL stop;
    BOOL isAnimating;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        currentIterations = 0;
        stop = NO;
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    self.layer.borderColor = [UIColor colorWithRed:0 green:84.0/255.0 blue:100.0/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1;
   
    [super drawRect:rect];
}

- (void) setNumber:(NSUInteger)number
{
    _number = number;
    _mainLabel.text = [NSString stringWithFormat:@"%d", _number];
    upperLabel.text = [NSString stringWithFormat:@"%d", _number+1];
}

- (void) addLabels
{
    
    _mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _mainLabel.font = [UIFont fontWithName:@"HelveticaNeue-thin" size:48.0];
    _mainLabel.text = [NSString stringWithFormat:@"%d", _number];
    _mainLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_mainLabel];
    
    
    CGRect upperRect = self.frame;
    upperRect.origin.y = 0 - upperRect.size.height;
    upperRect.origin.x = 0;
    
    
    upperLabel = [[UILabel alloc] initWithFrame:upperRect];
    
    upperLabel.backgroundColor = [UIColor clearColor];
    upperLabel.textAlignment = NSTextAlignmentCenter;
    upperLabel.font = [UIFont fontWithName:@"HelveticaNeue-thin" size:48.0];
    upperLabel.text = [NSString stringWithFormat:@"%d", _number+1];
    
    [self addSubview:upperLabel];
}

- (void) animateComponent
{
    if (isAnimating)
        stop = YES;
    
    isAnimating = YES;
    [self startAnimatingWithVelocity:__componentVelocity];
}

- (void) startAnimatingWithVelocity:(double)velocity
{
  
    [UIView animateWithDuration:velocity delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGRect centerFrame = _mainLabel.frame;
        centerFrame.origin.y += self.frame.size.height;
        
        CGRect upperRect = upperLabel.frame;
        upperRect.origin.y += self.frame.size.height;
        
        upperLabel.frame = upperRect;
        _mainLabel.frame = centerFrame;
    }
                     completion:^(BOOL finished)
    {
        //Moving labels to initial position
        
                         UILabel *templabel = _mainLabel;
                         
                         CGRect upperRect = templabel.frame;
                         upperRect.origin.y = 0 - upperRect.size.height;
                         templabel.frame = upperRect;
        
                         NSInteger currentNumber = [_mainLabel.text integerValue];
                         NSInteger newNumber = currentNumber+2;
        
                         if (newNumber >9)
                             newNumber-=10;
                         
                         templabel.text = [NSString stringWithFormat:@"%ld",(long)newNumber];
                         
                         _mainLabel = upperLabel;
                          upperLabel = templabel;
        
        //Estimating velocity
                         double newVelocity = velocity;
                         if (currentIterations > _iterations)
                         {
                             double x = log(velocity);
                             newVelocity = exp(x+0.4);
                         }
                         
                         if (newVelocity >= 0.7 || stop)
                         {
                             currentIterations = 0;
                             stop = NO;
                             if (newVelocity > 0.7)
                                 isAnimating = NO;
                             return;
                         }
                         
                         currentIterations ++;
                         [self startAnimatingWithVelocity: newVelocity];
                         
                     }];
}


- (void) awakeFromNib
{
    self.clipsToBounds = YES;
    
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
    
    [self addLabels];
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
