//
//  ATPictureDescriptionViewController.h
//  Tretyakovka
//
//  Created by Mac on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATPictureDescriptionViewController : UIViewController <UIScrollViewDelegate>{
    
    UITextView      * _text;
    CGPoint         start;
    UIImageView     *image;
    UIScrollView    *scrollView;
    int             page;
}

@property (nonatomic, strong) NSMutableArray* pictures;

-(id) initWithType: (int) typeNumber picture: (int) pictureNumber division: (NSMutableArray*) pictures;
-(void) showText;
-(void) swipe;
-(void) leftSwipe;

@end
