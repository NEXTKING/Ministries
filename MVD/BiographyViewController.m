//
//  BiographyViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 19.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rigts reserved.
//

#import "BiographyViewController.h"
#import "BiographyInformation.h"
#import <QuartzCore/QuartzCore.h>

@interface BiographyYear()

@end

@implementation BiographyYear

@end



@interface BiographyViewController ()
{
    NSArray *sortedBiography;
}

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
    
    [self sortBiography];
    
    _imageView.layer.cornerRadius = 44;
    _imageView.layer.masksToBounds = YES;
    _imageView.image = _humanInfo.image;
    
    _clipView.scrollView.contentSize = CGSizeMake(1000, 285);
    CGFloat width = _clipView.scrollView.frame.size.width;
    if (sortedBiography.count > 0)
        _noBiographyLabel.hidden = YES;
    
    for (int i = 0; i < sortedBiography.count; ++i)
    {
        CGFloat space = 0;
        if (i == 0)
            space = 5;
        else
            space = i*10;
        
        [[NSBundle mainBundle] loadNibNamed:@"BiographyUnitView" owner:self options:Nil];
        BiographyUnitView *view = self.biographyView;
        self.biographyView = Nil;
        
        BiographyYear *biographyYear = sortedBiography[i];
        view.yearLabel.text = [NSString stringWithFormat:@"%d", biographyYear.year];
        
        NSMutableString *finalText = [NSMutableString new];
        
        for (NSString *info in biographyYear.events)
            [finalText appendFormat:@"- %@\n\n", info];
        view.textView.text = finalText;
        
        
        view.contentView.layer.borderWidth = 1.0;
        view.contentView.layer.borderColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0].CGColor;
        
        CGRect viewFrame = view.frame;
        viewFrame.origin.x = width*i;
        view.frame = viewFrame;
        
        [_clipView.scrollView addSubview:view];
    }
    
    _clipView.scrollView.contentSize = CGSizeMake(sortedBiography.count*width, 285);
    _clipView.scrollView.delegate = self;
    _clipView.scrollView.contentOffset = CGPointMake((sortedBiography.count-1)*width, 0);
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _humanInfo.lastName, _humanInfo.firstName, _humanInfo.givenName];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) sortBiography
{
    NSMutableArray *sorted = [NSMutableArray new];
    
    NSEnumerator *eventsEnumerator = [_humanInfo.biography objectEnumerator];
    BiographyInformation *currentBiographyInfo = nil;
    while (currentBiographyInfo = [eventsEnumerator nextObject]) {
        
        //BOOL found = NO;
        BiographyYear *biographyYear = nil;
        for (BiographyYear *currentYear in sorted)
        {
            if (currentBiographyInfo.year == currentYear.year)
                biographyYear = currentYear;
        }
        
        if (!biographyYear)
        {
            biographyYear = [BiographyYear new];
            biographyYear.year = currentBiographyInfo.year;
            [sorted addObject:biographyYear];
        }
        
        NSMutableArray *oldEvents = nil;
        
        if (biographyYear.events)
            oldEvents = [NSMutableArray arrayWithArray:biographyYear.events];
        else
            oldEvents = [NSMutableArray new];
        
        [oldEvents addObject:currentBiographyInfo.text];
        
        biographyYear.events = oldEvents;
    }
    
    BOOL b = NO;
    NSArray *sortedArray = [sorted sortedArrayUsingFunction:biographyYearSort context:&b];
    
    sortedBiography = sortedArray;
}

NSInteger biographyYearSort(id event1, id event2, void *reverse)
{
    BiographyYear *firstEvent = (BiographyYear*)event1;
    BiographyYear *secondEvent = (BiographyYear*)event2;
    
    NSComparisonResult comparison = NSOrderedSame;
    if (firstEvent.year > secondEvent.year) {
        
        comparison = NSOrderedDescending;
    }
    else
        comparison = NSOrderedAscending;
    
    if (*(BOOL *)reverse == YES) {
        return 0 - comparison;
    }
    return comparison;
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
