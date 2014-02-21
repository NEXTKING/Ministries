//
//  AnalyticsViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 31.01.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "AnalyticsViewController.h"
#import "AnalyticaInfoCell.h"

@interface AnalyticsViewController ()

@end

@implementation AnalyticsViewController

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
    _tableView.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
    
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil)
    {
        
            AnalyticaInfoCell *infoCell = [[[NSBundle mainBundle] loadNibNamed:@"AnalyticsInfoCell" owner:self options:nil] objectAtIndex:0];
            if (indexPath.row == 0)
            {
                infoCell.nameLabel.text = @"Выбрать период";
            }
        
            cell = infoCell;
            
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}


@end
