//
//  FriendsViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 13.03.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "FriendsViewController.h"
#import "HumanViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

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
    self.title = @"В кругу друзей";
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@.%@.", _humanInfo.lastName, [_humanInfo.firstName substringToIndex:1], [_humanInfo.givenName substringToIndex:1]];
    
    NSArray *picturesArray = [NSArray arrayWithObjects:@"Путов.jpg", @"Путов.jpg", @"Путов.jpg", @"Путов.jpg", @"Путов.jpg", @"Путов.jpg", @"Путов.jpg", @"Путов.jpg", @"Путов.jpg",@"Путов.jpg", nil];
    Carousel *carousel = [[Carousel alloc] initWithArrayOfPictures:picturesArray delegate:self];
    carousel.frame = CGRectMake(0, 0, 320, _containerView.frame.size.height);
    carousel.radius = 160.0f;
    [_containerView addSubview:carousel];
    
    _photoImage.layer.borderWidth = 2.0;
    _photoImage.layer.borderColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:216.0/255.0 alpha:1.0].CGColor;
    _photoImage.image = _humanInfo.image;
    [_photoImage setClipsToBounds:YES];
    
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = CGRectMake(0, _infoLabel.frame.size.height-0.5, _infoLabel.frame.size.width, 0.5f);
    TopBorder.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0].CGColor;
    [_infoLabel.layer addSublayer:TopBorder];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, 0, _infoLabel.frame.size.width, 0.5f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0].CGColor;
    [_infoLabel.layer addSublayer:bottomBorder];
    
    //carousel.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat) heightOfViews
{
    return 50;
}

- (CGFloat) widthOfViews
{
    return 50;
}


- (void) carousel:(Carousel *)carousel didSelectImageWithIndex:(NSUInteger)index
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HumanViewController* human = [storyboard instantiateViewControllerWithIdentifier:@"Human"];
    [self.navigationController pushViewController:human animated:YES];
}

- (void) carousel:(Carousel *)carousel currentImageChangedToIndex:(NSUInteger)index
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
