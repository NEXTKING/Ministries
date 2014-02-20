//
//  ATPictureDescriptionViewController.m
//  Tretyakovka
//
//  Created by Mac on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATPictureDescriptionViewController.h"
#import "UIImage+resize.h"

@implementation ATPictureDescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(id) initWithType:(int)typeNumber picture:(int)pictureNumber division:(NSMutableArray*) pictures{
    self = [super init];
    if (self) {
        self.pictures = pictures;
        
        self.title = [NSString stringWithFormat:@"%d/%d", pictureNumber+1, [pictures count]];
        self.view.tag = typeNumber;
        
        page = pictureNumber;
        
        scrollView    =   [   [UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 470)];
        scrollView.backgroundColor = [UIColor redColor];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            scrollView.frame = CGRectMake(0, 0, 1024, 655);
        
        scrollView.tag  =   typeNumber;
        
        [self.view      addSubview:scrollView];
        [scrollView     setDelegate:self];
        [scrollView     setShowsVerticalScrollIndicator:NO];
        [scrollView     setShowsHorizontalScrollIndicator:NO];
        [scrollView     setMinimumZoomScale:1.0];
        [scrollView     setMaximumZoomScale:3.0];
        [scrollView     setBackgroundColor:[UIColor blackColor]];

        
        
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[pictures objectAtIndex:pictureNumber]]];
        image.frame = scrollView.frame;
        image.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:image];
        
       
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            _text = [[UITextView alloc] initWithFrame:CGRectMake(0, 655, 1024, 200)];
         _text.font = [UIFont systemFontOfSize:20];
        }
        else {
             _text = [[UITextView alloc] initWithFrame:CGRectMake(0, 480, 320, 150)];
         _text.font = [UIFont systemFontOfSize:13];
        }
        _text.backgroundColor   = [UIColor blackColor];
        [_text setEditable:NO];
        _text.alpha             =   0.87;
        _text.textColor         =   [UIColor whiteColor];
        _text.text              =   @"Some text";
        _text.hidden            =   YES;
        [self.view          addSubview:_text];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showText)];
        [self.view addGestureRecognizer:tap];
       
        UISwipeGestureRecognizer *swipe     =   [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
        [self.view addGestureRecognizer:swipe];
        
        UISwipeGestureRecognizer *leftSwipe     =   [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
        leftSwipe.direction     =   UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:leftSwipe];
    }
    return self;
}

#pragma mark - scroll delegate

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scroll {
    UIView* view    =   [scroll.subviews objectAtIndex:0];
    return view;
}


#pragma mark - animation 

-(void) swipe {
    
    if (_pictures.count -1     !=  page) {
    [UIView animateWithDuration:0.25
     
                     animations:^{ 
                         
                         [image     setAlpha:0.0];
                         
                     }
     
                     completion:^(BOOL  completed){
                         page++;
                         [image setImage:   [UIImage imageNamed:    _pictures[page]]];
                         _text.text             =   @"Some text";
                         self.title             =   [NSString stringWithFormat:@"%d/%d", page+1, [_pictures count]];
                         
                         [UIView animateWithDuration:0.5
                          
                                          animations:^{ 
                                              
                                              [image    setAlpha:1.0];
                                              
                                          }
                          
                                          completion:^(BOOL  completed){
                                              
                                          }    
                          
                          ];

                          
                     }    
     
     ];
    }

}

-(void) leftSwipe {
    if (page!=0 ) {
        [UIView animateWithDuration:0.25
         
                         animations:^{ 
                             
                             [image setAlpha:0.0];
                             
                         }
         
                         completion:^(BOOL  completed){
                             page--;
                             [image setImage:[UIImage imageNamed:_pictures[page]]];
                             _text.text = @"Some text";
                             self.title = [NSString stringWithFormat:@"%d/%d", page+1, [_pictures count]];
                             
                             [UIView animateWithDuration:0.5
                              
                                              animations:^{ 
                                                  
                                                  [image setAlpha:1.0];
                                                  
                                              }
                              
                                              completion:^(BOOL  completed){
                                                  
                                              }    
                              
                              ];
                             
                             
                         }    
         
         ];
    }

}

-(void) showText {
    if ([_text isHidden]) {
        [_text setHidden:NO];    
        [UIView animateWithDuration:0.5
         
                         animations:^{ 
                             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                 _text.frame = CGRectMake(0, 455, 1025, 200);
                             else
                                 
                                 _text.frame = CGRectMake(0, 300, 320, 130);
                         }
         
                         completion:^(BOOL  completed){
                             
                         }    
         
         ];
    }
    else 
        [UIView animateWithDuration:0.3
         
                         animations:^{ 
                             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                 _text.frame = CGRectMake(0, 655, 1024, 200);
                             else
                                 _text.frame = CGRectMake(0, 480, 320, 130);
                             
                         }
         
                         completion:^(BOOL  completed){
                             [_text setHidden:YES];
                         }    
         ]; 
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    scrollView.userInteractionEnabled = NO;
    
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
