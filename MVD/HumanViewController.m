//
//  HumanViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 12.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "HumanViewController.h"
#import "BiographyViewController.h"
#import "HumanNameCell.h"
#import "RankCell.h"
#import "CommonInfoCell.h"
#import "HumanIncomeViewController.h"
#import "NewsViewController.h"
#import "ATPictureDescriptionViewController.h"

@interface HumanViewController ()

@end

@implementation HumanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.navigationController.navigationBarHidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0];
    self.title = @"Путов В.В.";
    //UIImageView* image =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    //image.frame = _tableView.frame;
    //self.tableView.backgroundView = image;
    _backgroundView.image = [UIImage imageNamed:@"grayBackground.jpg"];
    self.navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //self.navigationItem.rightBarButtonItem = _barButtonItem;
    
    UIImage *myImage = [UIImage imageNamed:@"звезда.png"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setImage:myImage forState:UIControlStateNormal];
    myButton.showsTouchWhenHighlighted = YES;
    myButton.frame = CGRectMake(0.0, 0.0, myImage.size.width, myImage.size.height);
    
    [myButton addTarget:self action:@selector(favourites:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    _tableView.backgroundColor = [UIColor clearColor];
    [self setNeedsStatusBarAppearanceUpdate];
    _photoImage.layer.borderWidth = 2.0;
    _photoImage.layer.borderColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:216.0/255.0 alpha:1.0].CGColor;
    
    //self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view from its nib.
}


- (IBAction) favourites: (id) sender
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Выберите дествие" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:Nil otherButtonTitles:@"На контроль", nil];
    [actionSheet showInView:_scrollView];
}

- (void) viewDidAppear:(BOOL)animated
{
    _backgroundView.translatesAutoresizingMaskIntoConstraints = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

#pragma mark - Table View Delegate & Data source

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

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil)
    {
        if (tableView == _littleTableView)
        {
            if (indexPath.row == 0)
            {
                HumanNameCell *nameCell = [[[NSBundle mainBundle] loadNibNamed:@"HumanNameCell" owner:self options:nil] objectAtIndex:0];
                nameCell.nameLabel.text = @"Путов Валерий";
                nameCell.givenNameLabel.text = @"Владимирович";
                cell = nameCell;
            }
            else if (indexPath.row == 2)
            {
                RankCell *rank = [[[NSBundle mainBundle] loadNibNamed:@"RankCell" owner:self options:nil] objectAtIndex:0];
                rank.rankLabel.text = @"Генерал-полковник";
                rank.rankImage.image = [UIImage imageNamed:@"погон.png"];
                cell = rank;
            }
            else
            {
                cell = [[UITableViewCell alloc] init];
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.minimumScaleFactor = 0.5;
                cell.textLabel.text = @"2 Января 1954 (59 лет)";
                CGRect rect = cell.textLabel.frame;
                rect.origin.x = 40;
                cell.textLabel.frame = rect;
            }
        }
        else
        {
            CommonInfoCell *infoCell = [[[NSBundle mainBundle] loadNibNamed:@"CommonInfoCell" owner:self options:nil] objectAtIndex:0];
            if (indexPath.row == 0)
            {
                infoCell.image.image = [UIImage imageNamed:@"биография.png"];
                infoCell.nameLabel.text = @"Биография";
            }
            else if (indexPath.row == 1)
            {
                infoCell.image.image = [UIImage imageNamed: @"доходы.png"];
                infoCell.nameLabel.text = @"Доходы и имущество";
            }
            else if (indexPath.row == 2)
            {
                infoCell.image.image = [UIImage imageNamed: @"в кругу друзей.png"];
                infoCell.nameLabel.text = @"В кругу друзей";
            }
            else if (indexPath.row == 3)
            {
                infoCell.image.image = [UIImage imageNamed: @"сми.png"];
                infoCell.nameLabel.text = @"СМИ";
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
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        BiographyViewController *biography = [[BiographyViewController alloc] init];
        [self.navigationController pushViewController:biography animated:YES];
    }
    if (indexPath.row == 1)
    {
        HumanIncomeViewController *income = [[HumanIncomeViewController alloc] init];
        [self.navigationController pushViewController:income animated:YES];
    }
    if (indexPath.row == 3)
    {
        NewsViewController *news = [[NewsViewController alloc] init];
        [self.navigationController pushViewController:news animated:YES];
    }
        
}

- (IBAction) gestureHandler:(id)sender
{
    NSMutableArray *pictures = [NSMutableArray arrayWithObjects:@"Путов.jpg", @"mvd_dark.png", @"кадры.png" ,nil];
    ATPictureDescriptionViewController *description = [[ATPictureDescriptionViewController alloc] initWithType:0 picture:0 division:pictures];
    [self.navigationController pushViewController:description animated:YES];
}


@end
