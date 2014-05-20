//
//  ATPictureDescriptionViewController.m
//  Tretyakovka
//
//  Created by Mac on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATPictureDescriptionViewController.h"
#import "UIImage+resize.h"
#import "MCPServer.h"

@implementation ATPictureDescriptionViewController
{
    UIActivityIndicatorView *activityIndicator;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) getImageComplete:(int)result image:(UIImage *)sentImage imgId:(NSString *)imageId reqId:(id)requestId
{
    NSInteger reqId = [requestId intValue];
    [_pictures replaceObjectAtIndex:reqId withObject:sentImage];
    if (page == reqId)
    {
        image.image = sentImage;
        image.alpha = 1.0;
    }
    [activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(id) initWithPictures:(NSMutableArray *)pictures
{
    self = [super init];
    if (self) {
        self.pictures = pictures;
        
        self.title = [NSString stringWithFormat:@"%d/%lu", 1,(unsigned long)[pictures count]];
        
        page = 0;
        
        scrollView    =   [   [UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 470)];
        scrollView.backgroundColor = [UIColor redColor];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            scrollView.frame = CGRectMake(0, 0, 1024, 655);
        
        [self.view      addSubview:scrollView];
        [scrollView     setDelegate:self];
        [scrollView     setShowsVerticalScrollIndicator:NO];
        [scrollView     setShowsHorizontalScrollIndicator:NO];
        [scrollView     setMinimumZoomScale:1.0];
        [scrollView     setMaximumZoomScale:3.0];
        [scrollView     setBackgroundColor:[UIColor blackColor]];

        
        
        image = [[UIImageView alloc] initWithImage:pictures[0]];
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
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        CGRect activityFrame = activityIndicator.frame;
        activityFrame.origin.x = (self.view.frame.size.width)/2 - activityFrame.size.width/2;
        activityFrame.origin.y = self.view.frame.size.height/2 - activityFrame.size.height/2;
        activityIndicator.frame = activityFrame;
        [self.view addSubview:activityIndicator];
        activityIndicator.hidesWhenStopped = YES;
        [activityIndicator stopAnimating];
        
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
                         if ([_pictures[page] isKindOfClass:[UIImage class]])
                         {
                             [image setImage:   _pictures[page]];
                             [activityIndicator stopAnimating];
                         }
                         else
                         {
                             [activityIndicator startAnimating];
                             if ([_pictures[page] isKindOfClass:[NSNull class]])
                             {
                                     [[MCPServer instance] getImage:_links[page] reqId:[NSNumber numberWithInt:page] delegate:self];
                                     image.image = nil;
                                     [_pictures replaceObjectAtIndex:page withObject:[_links objectAtIndex:page]];
                             }
                            else
                             {
                                 return;
                             }
                         }
                         
                         _text.text             =   @"Some text";
                         self.title             =   [NSString stringWithFormat:@"%d/%lu", page+1, (unsigned long)[_pictures count]];
                         
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
                             
                             if ([_pictures[page] isKindOfClass:[UIImage class]])
                             {
                                 [image setImage:  _pictures[page]];
                                 [activityIndicator stopAnimating];
                             }
                             else
                             {
                                 [activityIndicator startAnimating];
                                 if ([_pictures[page] isKindOfClass:[NSNull class]])
                                 {
                                     [[MCPServer instance] getImage:_links[page] reqId:[NSNumber numberWithInt:page] delegate:self];
                                     image.image = nil;
                                     [_pictures replaceObjectAtIndex:page withObject:[_links objectAtIndex:page]];
                                 }
                                 else
                                 {
                                     return;
                                 }
                             }
                             
                             _text.text = @"Some text";
                             self.title = [NSString stringWithFormat:@"%d/%lu", page+1, (unsigned long)[_pictures count]];
                             
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
