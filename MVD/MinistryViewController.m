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
#import "AnalyticsViewController.h"
#import "MinistryStructureViewController.h"
#import "EmployeesViewController.h"

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
    if (_region && ![_region isEqualToString:@""])
    {
        _regionLabel.hidden = NO;
        _regionLabel.text = [NSString stringWithFormat:@"Регион: %@", _region];
        [_regionLabel sizeToFit];
    }
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0];
    self.title = @"МВД России";
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
    UIStoryboard *storyboard = nil;
    EmployeesViewController *employees = nil;
    UIViewController *viewController = nil;
    switch (sender.tag) {
        case 0:
            viewController = [[MinistryStructureViewController alloc] init];
            break;
        case 1:
            viewController = [[EmployeesViewController alloc] init];
            employees = (EmployeesViewController *)viewController;
            employees.type = ETypeCommon;
            break;
        case 2:
            //viewController =  [[AnalyticsViewController alloc] init];
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"Analytics"];
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
