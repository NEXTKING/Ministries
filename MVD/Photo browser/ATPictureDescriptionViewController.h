//
//  ATPictureDescriptionViewController.h
//  Tretyakovka
//
//  Created by Mac on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProtocol.h"

@interface ATPictureDescriptionViewController : UIViewController <UIScrollViewDelegate, ResourcesExchangeDelegate>{
    
    UITextView      * _text;
    CGPoint         start;
    UIImageView     *image;
    UIScrollView    *scrollView;
    int             page;
}

@property (nonatomic, strong) NSMutableArray* pictures;
@property (nonatomic, strong) NSArray *links;

-(id) initWithPictures: (NSMutableArray*) pictures;
-(void) showText;
-(void) swipe;
-(void) leftSwipe;

@end
