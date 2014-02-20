//
//  MinistryStructureDescriptionViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 13.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "MinistryStructureDescriptionViewController.h"

@interface MinistryStructureDescriptionViewController ()

@end

@implementation MinistryStructureDescriptionViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0];
    
    self.title = @"Следственный департамент";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
