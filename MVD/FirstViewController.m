//
//  FirstViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 05.11.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeriver_1_small.jpg"]];
    [im setFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:im];
   // NSArray *array = [[NSArray alloc] initWithObjects:@"timeriver_1_small.jpg", @"timeriver_2_small.jpg", @"timeriver_3_small.jpg",@"timeriver_4_small.jpg", @"timeriver_5_small.jpg", @"timeriver_6_small.jpg",@"timeriver_7_small.jpg", @"timeriver_8_small.jpg", @"timeriver_9_small.jpg",nil];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void) buttonHandler
{
   SecondViewController *second = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


-(CGFloat) heightOfViews {
    return 100.0f;
}

-(CGFloat) widthOfViews {
    return 50.0f;
}





@end
