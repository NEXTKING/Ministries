//
//  BiographyViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 19.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rigts reserved.
//

#import "BiographyViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BiographyViewController ()

@end

@implementation BiographyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Биография";
    
    _imageView.layer.cornerRadius = 44;
    _imageView.layer.masksToBounds = YES;
    
    _clipView.scrollView.contentSize = CGSizeMake(1000, 285);
    CGFloat width = _clipView.scrollView.frame.size.width;
    for (int i = 0; i < 5; ++i)
    {
        CGFloat space = 0;
        if (i == 0)
            space = 5;
        else
            space = i*10;
        
        [[NSBundle mainBundle] loadNibNamed:@"BiographyUnitView" owner:self options:Nil];
        BiographyUnitView *view = self.biographyView;
        self.biographyView = Nil;
        
        view.yearLabel.text = [NSString stringWithFormat:@"%d", 2010 + i];
        
        
        view.contentView.layer.borderWidth = 1.0;
        view.contentView.layer.borderColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0].CGColor;
        
        CGRect viewFrame = view.frame;
        viewFrame.origin.x = width*i;
        view.frame = viewFrame;
        
        [_clipView.scrollView addSubview:view];
    }
    
    _clipView.scrollView.contentSize = CGSizeMake(5*width, 285);
    _clipView.scrollView.delegate = self;
    _clipView.scrollView.contentOffset = CGPointMake(4*width, 0);
    
    // Do any additional setup after loading the view from its nib.
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scroll withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
