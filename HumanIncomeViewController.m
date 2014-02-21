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
{
    BOOL _isRightSwiped;
}

@end

@implementation HumanIncomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isRightSwiped = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //_segmentedControl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0];
    
    self.title = @"Доходы";
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

- (IBAction)leftSwipeSelector:(UISwipeGestureRecognizer*) sender
{
    if (!_isRightSwiped)
        return;
    else
        _isRightSwiped = NO;
    [self animateCharts:sender.direction];
    _prevLabel.text = @"2013";
    _nextLabel.text = @"2014";
    
}

- (IBAction)rightSwipeSelector:(UISwipeGestureRecognizer *)sender
{
    if (_isRightSwiped)
        return;
    else
        _isRightSwiped = YES;
    
    _prevLabel.text = @"2012";
    _nextLabel.text = @"2013";
    [self animateCharts:sender.direction];
}

- (void) animateCharts: (UISwipeGestureRecognizerDirection) direction
{
    NSInteger deltaWife =  _isRightSwiped ? 15:-15;
    NSInteger deltaMan =  _isRightSwiped  ? 25:-25;
    
    NSInteger deltaWifeRight = _isRightSwiped  ? 50:-50;
    NSInteger deltaManRight = _isRightSwiped  ? 25:-25;
   // _incomeManLeft.layer.anchorPoint = CGPointMake(0.5,1);
    
    NSInteger deltaPropertyManLeft =  _isRightSwiped ? 15:-15;
    NSInteger deltaPropertyManRight =  _isRightSwiped  ? 25:-25;
    
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //Left Income
        {
        CGRect wifeRect = _incomeWifeLeft.frame;
        wifeRect.origin.y += (deltaMan + deltaWife);
        wifeRect.size.height -= deltaWife;
        _incomeWifeLeft.frame = wifeRect;
        
        CGRect manRect = _incomeManLeft.frame;
        manRect.size.height -= deltaMan;
        manRect.origin.y +=deltaMan;
        _incomeManLeft.frame = manRect;
        }
        
        {
        //Right income
        CGRect manRect = _incomeManRighr.frame;
        manRect.size.height -= deltaManRight;
        manRect.origin.y += (deltaManRight + deltaWifeRight);
        _incomeManRighr.frame = manRect;
            
            CGRect wifeRect = _incomeWifeRight.frame;
            wifeRect.origin.y += (deltaWifeRight);
            wifeRect.size.height -= deltaWifeRight;
            _incomeWifeRight.frame = wifeRect;
        }
        
        //left property
        {
            CGRect manRect = _propertyManLeft.frame;
            manRect.size.height -= deltaPropertyManLeft;
            manRect.origin.y +=deltaPropertyManLeft;
            _propertyManLeft.frame = manRect;
        }
        
        //right property
        {
            CGRect wifeRect = _propertyWifeRight.frame;
            wifeRect.origin.y += (deltaPropertyManRight);
            _propertyWifeRight.frame = wifeRect;
            
            CGRect manRect = _propertyManRight.frame;
            manRect.size.height -= deltaPropertyManRight;
            manRect.origin.y +=deltaPropertyManRight;
            _propertyManRight.frame = manRect;
        }
        
        
        
    } completion:^(BOOL finished) {
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
