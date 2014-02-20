//
//  HumanIncomeViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 26.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "HumanIncomeViewController.h"
#import "CommonInfoCell.h"

@interface HumanIncomeViewController ()

@end

@implementation HumanIncomeViewController

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
    //_segmentedControl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0];
    
    self.title = @"Доходы";
    _background.image = [UIImage imageNamed:@"grayBackground.jpg"];
    _tableview.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil)
    {
        CommonInfoCell *infoCell = [[[NSBundle mainBundle] loadNibNamed:@"CommonInfoCell" owner:self options:nil] objectAtIndex:0];
        if (indexPath.row == 0)
        {
            infoCell.image.image = [UIImage imageNamed:@"биография.png"];
            infoCell.nameLabel.text = @"Доходы";
        }
        else if (indexPath.row == 1)
        {
            infoCell.image.image = [UIImage imageNamed: @"доходы.png"];
            infoCell.nameLabel.text = @"Земельные участки";
        }
        else if (indexPath.row == 2)
        {
            infoCell.image.image = [UIImage imageNamed: @"друзья.png"];
            infoCell.nameLabel.text = @"Жилая недвижимость";
        }
        else if (indexPath.row == 3)
        {
            infoCell.image.image = [UIImage imageNamed: @"сми.png"];
            infoCell.nameLabel.text = @"Транспорт";
        }
        cell = infoCell;
        
        if (indexPath.row != 3)
        {
            UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(60, cell.frame.size.height-1, cell.frame.size.width-15, 1)];
            separator.image = [UIImage imageNamed:@"background.jpg"];
            [cell addSubview:separator];
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
