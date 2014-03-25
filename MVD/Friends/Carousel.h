//
//  Carousel.h
//  animation_tr
//
//  Created by Denis Kurochkin on 14.01.12.
//  Copyright (c) 2012 nextkingrus@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CarouselDelegate;

@interface Carousel : UIView{
   
    CGPoint startPoint;
    CGFloat currentAngle, lastAngle;
    NSMutableArray *carouselViews;
    NSTimer* animationTimer, *centerTimer;
    UITouch* trackingTouch;
    UIView *currentView;
    CGFloat start;
    BOOL isTapped, firstTime;

}


-(id) initWithArrayOfPictures: (NSArray*) array delegate: (id<CarouselDelegate>) delegate;
- (void)setCarouselAngle:(float)angle;
-(void) refresh;
-(void) gestureRecognizer: (id) sender;

@property (nonatomic, unsafe_unretained) id<CarouselDelegate> delegate;
@property (nonatomic, setter = setRadius:) CGFloat radius;

@end

@protocol CarouselDelegate <NSObject>
-(CGFloat) heightOfViews;
-(CGFloat) widthOfViews;
-(void) carousel: (Carousel*) carousel  didSelectImageWithIndex: (NSUInteger) index ;
-(void) carousel:(Carousel *)carousel currentImageChangedToIndex:(NSUInteger)index;
@end