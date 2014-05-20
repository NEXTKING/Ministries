//
//  Carousel.m
//  animation_tr
//
//  Created by Denis Kurochkin on 14.01.12.
//  Copyright (c) 2012 nextkingrus@gmail.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Carousel.h"

@interface Carousel ()

@property (nonatomic, strong) NSArray* array;

@end

@implementation Carousel

@synthesize delegate = _delegate;
@synthesize radius = _radius;

-(void) setRadius:(CGFloat)radius{
    _radius = radius;
    [self setCarouselAngle:0.0f];
}


- (void)setCarouselAngle:(float)angle
{
    
    float angleToAdd = 360.0f / [carouselViews count];
    
    //Change currentView if required
    
    //Change angles
    
    for(UIView *view in carouselViews)
    {
        float angleInRadians = angle * M_PI / 180.0f;
        float xPosition =  _radius * sinf(angleInRadians);
        float yPosition =  _radius/2 * cosf(angleInRadians);
        
     
        float scale = 0.75f + 0.45f * (cosf(angleInRadians) + 1.0);
        
        view.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(xPosition, yPosition), scale, scale);
        

        view.alpha = - 0.6f + 0.8f * (cosf(angleInRadians) + 1.0);
        
    
        view.layer.zPosition = scale;
    
        angle += angleToAdd;
        
       // if (view.alpha<0.6)
       //     view.userInteractionEnabled = NO;
       // else
       //     view.userInteractionEnabled = YES;
        
    }
    if (firstTime == YES){
        UIView *view = [carouselViews objectAtIndex:0];
        start = view.frame.origin.x;
        firstTime = NO;
    }
}

- (void)animateAngle
{
    
    float angleNow = currentAngle;
    currentAngle += (currentAngle - lastAngle) * exp(-0.1);
    lastAngle = angleNow;
    [self setCarouselAngle:currentAngle];
    
    if(fabsf(lastAngle - currentAngle) < 0.001)
    {
        [animationTimer invalidate];
        animationTimer = nil;
    }
}
-(id) initWithArrayOfPictures:(NSArray *)array delegate:(id<CarouselDelegate>)delegate{
    _delegate = delegate;
    self = [super init];
    if (self) {
        self.array  =   array;
        [self   refresh];
        isTapped = NO;
        firstTime = YES;
           }
    return self;
}

-(void) gestureRecognizer: (id) sender{
    isTapped = YES;
    if ([centerTimer isValid])
        [centerTimer invalidate];
    UITapGestureRecognizer *send = sender;
    for (UIView *view in self.subviews){
        if (view == send.view && view==currentView){
            [_delegate carousel:self didSelectImageWithIndex:currentView.tag];
        }
        if (view == send.view){
            currentView = view;
            [_delegate carousel:self currentImageChangedToIndex:currentView.tag];
        }
    }
       // centerTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveToCenter) userInfo:nil repeats:YES];
        
        
}

-(void) moveToCenter{
    if (currentView.alpha<1.1999)
         {  
             if(currentView.frame.origin.x>start)
        currentAngle-=2.0;
    
             else
                 currentAngle+=2.0;
        [self setCarouselAngle:currentAngle];
    }
    else{
        [centerTimer invalidate];
        centerTimer = nil;
        //NSLog(@"%f, %f", currentView.frame.origin.x, start);
    }
        

}
-(void) refresh{
    for (UIView *view in self.subviews){
        [view removeFromSuperview];
    }
        CGRect frameForViews = CGRectMake(self.frame.size.width/2-[_delegate widthOfViews]/2,20, [_delegate widthOfViews], [_delegate heightOfViews]);
        NSLog(@"%f", self.frame.size.width);
        
        carouselViews = [[NSMutableArray alloc] initWithCapacity:[_array count]];
        long c = [_array count];
    for (int q =0; q<c; q++)
        {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_array objectAtIndex:q]]];
            image.frame = frameForViews;
            image.userInteractionEnabled = YES;
            
            image.layer.cornerRadius = 25;
            image.layer.masksToBounds = YES;
            
            image.contentMode = UIViewContentModeScaleAspectFill;
             [image addGestureRecognizer:tap];
            // UIView *view = [[UIView alloc] initWithFrame:frameForViews];
            
            //view.backgroundColor = [UIColor colorWithRed:(c&4) ? 1.0 : 0.0 green:(c&2) ? 1.0 : 0.0 blue:(c&1) ? 1.0 : 0.0 alpha:1.0];
            image.tag = q;
            [carouselViews addObject:image];
            [self addSubview:image];
        }
 
    if ([carouselViews count] != 0){
        currentView = [carouselViews objectAtIndex:0];
    }
        currentAngle = lastAngle = 0.0f;
        [self setCarouselAngle:currentAngle];
        

    }

-(void) setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self refresh];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!trackingTouch)
    {
        trackingTouch = [touches anyObject];
    
        [animationTimer invalidate];
        animationTimer = nil;
        lastAngle = currentAngle;
        isTapped = NO;
    }
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([touches containsObject:trackingTouch])
    {
    
        CGPoint locationNow = [trackingTouch locationInView:self];
        CGPoint locationThen = [trackingTouch previousLocationInView:self];
        
        lastAngle = currentAngle;
        currentAngle += (locationNow.x - locationThen.x) * 180.0f / self.frame.size.width;
        [self setCarouselAngle:currentAngle];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    if([touches containsObject:trackingTouch])
    {
        trackingTouch = nil;
        if (isTapped == NO)
        animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateAngle) userInfo:nil repeats:YES];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


@end