//
//  EmployeesViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 07.03.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "EmployeesViewController.h"
#import "HumanInformation.h"
#import "HumanCell.h"
#import "HumanViewController.h"

@interface EmployeesViewController ()
{
    NSMutableArray *_humans;
}

@end

@implementation EmployeesViewController

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
    
    self.navigationController.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    _humans = [[NSMutableArray alloc] init];
    
    {
        HumanInformation *humanInfo = [HumanInformation new];
        humanInfo.firstName = @"Владимир";
        humanInfo.lastName = @"Путов";
        humanInfo.givenName = @"Владимирович";
        [_humans addObject:humanInfo];
    }
    
    {
        HumanInformation *humanInfo = [HumanInformation new];
        humanInfo.firstName = @"Владимир";
        humanInfo.lastName = @"Путов";
        humanInfo.givenName = @"Владимирович";
        [_humans addObject:humanInfo];
    }
    
    {
        HumanInformation *humanInfo = [HumanInformation new];
        humanInfo.firstName = @"Владимир";
        humanInfo.lastName = @"Путов";
        humanInfo.givenName = @"Владимирович";
        [_humans addObject:humanInfo];
    }
    
    {
        HumanInformation *humanInfo = [HumanInformation new];
        humanInfo.firstName = @"Владимир";
        humanInfo.lastName = @"Путов";
        humanInfo.givenName = @"Владимирович";
        [_humans addObject:humanInfo];
    }
    
    {
        HumanInformation *humanInfo = [HumanInformation new];
        humanInfo.firstName = @"Владимир";
        humanInfo.lastName = @"Путов";
        humanInfo.givenName = @"Владимирович";
        [_humans addObject:humanInfo];
    }
    
    {
        HumanInformation *humanInfo = [HumanInformation new];
        humanInfo.firstName = @"Владимир";
        humanInfo.lastName = @"Путов";
        humanInfo.givenName = @"Владимирович";
        [_humans addObject:humanInfo];
    }

    

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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil)
    {
        HumanCell* humanCell = (HumanCell*)[[[NSBundle mainBundle] loadNibNamed:@"HumanCell" owner:self options:nil] objectAtIndex:0];
        
        
            HumanInformation *human = [_humans objectAtIndex:indexPath.row];
        
        
        NSString *nameShort = [[human.firstName substringToIndex:1] uppercaseString];
        NSString *givenShort = [[human.givenName substringToIndex:1] uppercaseString];
            humanCell.nameLabel.text = [NSString stringWithFormat:@"%@ %@.%@.", human.lastName, nameShort, givenShort];
        
        
           // humanCell.rankLabel.text = @"Занимаемая должность";
            humanCell.photoView.image = [UIImage imageNamed:@"Путов.jpg"];
            humanCell.photoView.layer.cornerRadius = 30;
            humanCell.photoView.layer.masksToBounds = YES;
        humanCell.nameLabel.textColor = [UIColor blackColor];
        humanCell.rankLabel.textColor = [UIColor blackColor];
        humanCell.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        humanCell.rankLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        
        switch (_type) {
            case ETypeCommon:
                humanCell.rankLabel.text = @"Занимаемая должность";
                break;
            case ETypeAwarded:
                humanCell.rankLabel.text = @"Название награды";
                break;
            case ETypeHired:
                humanCell.rankLabel.text = @"Новая должность";
                break;
            case ETypeFired:
                humanCell.rankLabel.text = @"Старая должность";
                break;
            case ETypePromoted:
                humanCell.rankLabel.text = @"Новое звание";
                break;
                
            default:
                break;
        }
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"стрелка.png"]];
        arrow.frame = CGRectMake(0, 0, 26, 23);
        arrow.contentMode = UIViewContentModeScaleAspectFit;
        humanCell.accessoryView = arrow;
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:153.0/255.0 blue:157.0/255.0 alpha:1.0];
        [humanCell setSelectedBackgroundView:bgColorView];
        
        cell = humanCell;
    }
    
    return cell;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
     HumanViewController* human = [storyboard instantiateViewControllerWithIdentifier:@"Human"];
    [self.navigationController pushViewController:human animated:YES];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
