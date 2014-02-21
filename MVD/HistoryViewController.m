//
//  HistoryViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 21.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"
#import <QuartzCore/QuartzCore.h>

@interface HistoryViewController ()

@end

@implementation HistoryViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"History"];

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
    return 2;
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *hf = (UITableViewHeaderFooterView*) view;
    hf.contentView.backgroundColor = [UIColor colorWithRed:126.0/255.0 green:151.0/255.0 blue:157.0/255.0 alpha:1.0];
    [hf.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:19]];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"13 Января";
    else
        return @"11 Января 2014";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    return 3;
    else
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"History";
    
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.mainImageView.layer.cornerRadius = 30;
    cell.mainImageView.layer.masksToBounds = YES;
    
    if (indexPath.section == 0)
    {
    switch (indexPath.row) {
        case 0:
            cell.nameLabel.text = @"Иванов И.И.";
            break;
        case 1:
            cell.mainImageView.image = [UIImage imageNamed:@"mvd_dark.png"];
            cell.nameLabel.text = @"МЧС России";
            break;
        case 2:
            
            cell.nameLabel.text = @"Медведев В.И.";
            break;
        case 3:
            cell.mainImageView.image = [UIImage imageNamed:@"mvd_dark.png"];
            cell.nameLabel.text = @"МВД России";
            break;
        case 4:
            cell.nameLabel.text = @"Морозов К.А.";
            break;
            
        default:
            break;
    }
    }
    else {
        
        switch (indexPath.row) {
            case 0:
                cell.mainImageView.image = [UIImage imageNamed:@"mvd_dark.png"];
                cell.nameLabel.text = @"МВД России";
                break;
            case 1:
                cell.nameLabel.text = @"Морозов К.А.";
                break;
                
            default:
                break;
    }
    }
    
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
