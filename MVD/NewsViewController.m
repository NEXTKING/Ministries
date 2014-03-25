//
//  NewsViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 26.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDescriptionViewController.h"
#import "NewsCell.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayBackground.jpg"]];
    self.title = @"СМИ";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NewsCell *newsCell = (NewsCell*)[[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] objectAtIndex:0];
        cell = newsCell;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    // Configure the cell...
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDescriptionViewController *description = [[NewsDescriptionViewController alloc] init];
    [self.navigationController pushViewController:description animated:YES];
}


@end
