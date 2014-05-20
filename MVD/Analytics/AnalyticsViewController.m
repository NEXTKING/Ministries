//
//  AnalyticsViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 31.01.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "AnalyticsViewController.h"
#import "AnalyticaInfoCell.h"
#import "EmployeesViewController.h"

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
    [self repeatAnimation:Nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(repeatAnimation:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
	// Do any additional setup after loading the view.
}

- (IBAction)repeatAnimation:(id)sender
{
    NSArray *components = [NSArray arrayWithObjects:_component0, _component1, _component2, _component3, _component4, _component5, nil];
    for (int i = 0; i < components.count; ++i)
    {
        CounterComponentView *componentView = components[i];
        componentView.iterations = 5+ 8*i;
        componentView.number = (rand() % 10);
        [componentView animateComponent];
    }
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

- (IBAction)buttonHandler:(UIButton*)sender
{
    NSInteger tag = sender.tag;
    EmployeesViewController *employees = [[EmployeesViewController alloc] init];
    
    switch (tag) {
        case 0:
            employees.type = ETypeHired;
            break;
        case 1:
            employees.type = ETypeFired;
            break;
        case 2:
            employees.type = ETypeAwarded;
            break;
        case 3:
            employees.type = ETypePromoted;
            break;
            
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:employees animated:YES];
    employees.title = @"Назначены";
}


@end
