//
//  MinistryViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 27.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "MinistryViewController.h"
#import "CommonInfoCell.h"
#import "NewsViewController.h"
#import "MinistryAnalyticsViewController.h"
#import "MinistryStructureViewController.h"

@interface MinistryViewController ()

@end

@implementation MinistryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0];
    self.title = @"МВД";
    //UIImageView* image =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    //image.frame = _tableView.frame;
    //self.tableView.backgroundView = image;
   // _backgroundView.image = [UIImage imageNamed:@"grayBackground.jpg"];
    self.navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    _scrollView = nil;
}

- (IBAction)buttonAction:(UIButton *)sender
{
    UIViewController *viewController = nil;
    switch (sender.tag) {
        case 0:
            viewController = [[MinistryStructureViewController alloc] init];
            break;
        case 2:
            viewController =  [[MinistryAnalyticsViewController alloc] init];
            break;
        case 3:
             viewController =  [[NewsViewController alloc] init];
            break;
            
        default:
            break;
    }
    
    if (viewController)
        [self.navigationController pushViewController:viewController animated:YES];
}

@end
