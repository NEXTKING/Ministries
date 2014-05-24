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
#import "FriendsViewController.h"

#import <AddressBook/AddressBook.h>

static const char* GroupName = "iЧиновники";

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
    
    //Creating acknowledgements
    self.title = [NSString stringWithFormat:@"%@ %@.%@.", _humanInfo.lastName, [_humanInfo.firstName substringToIndex:1], [_humanInfo.givenName substringToIndex:1]];
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
    [_photoImage setClipsToBounds:YES];
    
    [self fillViewWithData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) fillViewWithData
{
    //Setting name
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _humanInfo.lastName, _humanInfo.firstName, _humanInfo.givenName];
    
    //Setting rank
    if (_humanInfo.rank)
        _rankLabel.text = _humanInfo.rankName;
    else
        _rankLabel.text = @"-";
    
    //Setting post
    
    if (_humanInfo.post)
        _postLabel.text = _humanInfo.postName;
    else
        _postLabel.text = @"-";
    
    //Setting birth date
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    
    
    NSString *birthDate = [dateFormatter stringFromDate:_humanInfo.birthDate];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:_humanInfo.birthDate];
    NSDateComponents *currentComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger age = [currentComponents year] - [components year];
    NSString *postAgeString = @"лет";
    
    switch (age % 10) {
        case 1:
            postAgeString = @"год";
            break;
        case 2:
        case 3:
        case 4:
            postAgeString = @"года";
            break;
        default:
            break;
    }
    
    _birthdayLabel.text = [NSString stringWithFormat:@"%@ (%ld %@)", birthDate, (long)age, postAgeString];
    _photoImage.image = _humanInfo.image;
    _photoImage.layer.borderWidth = 2.0;
    _photoImage.layer.borderColor = [UIColor colorWithRed:201.0/255.0 green:212.0/255.0 blue:216.0/255.0 alpha:1.0].CGColor;
    
    
}


- (IBAction) favourites: (id) sender
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Выберите дествие" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:Nil otherButtonTitles:@"На контроль", @"Добавить в контакты", @"Отправить на почту", @"Отправить на печать", nil];
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
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        BiographyViewController *biography = [[BiographyViewController alloc] init];
        biography.humanInfo = _humanInfo;
        [self.navigationController pushViewController:biography animated:YES];
    }
    if (indexPath.row == 1)
    {
        HumanIncomeViewController *income = [[HumanIncomeViewController alloc] init];
        income.humanInfo = _humanInfo;
        [self.navigationController pushViewController:income animated:YES];
    }
    if (indexPath.row == 2)
    {
        FriendsViewController *income = [[FriendsViewController alloc] init];
        income.humanInfo = _humanInfo;
        [self.navigationController pushViewController:income animated:YES];
    }
    if (indexPath.row == 3)
    {
        NewsViewController *news = [[NewsViewController alloc] init];
        news.human = _humanInfo;
        [self.navigationController pushViewController:news animated:YES];
    }
        
}

#pragma mark - Photo browser

- (IBAction) gestureHandler:(id)sender
{
    
    NSMutableArray *pictures = [NSMutableArray new];
    if (_humanInfo.image)
        [pictures addObject:_humanInfo.image];
    
    for (NSUInteger i = 0; i<_humanInfo.photos.count - 1; ++i)
         [pictures addObject:[NSNull null]];
    
    ATPictureDescriptionViewController *description = [[ATPictureDescriptionViewController alloc] initWithPictures:pictures];
    description.links = _humanInfo.photos;
    [self.navigationController pushViewController:description animated:YES];
}

#pragma mark - Person Favourites

- (void) dismissActionSheet : (UIActionSheet*) actionSheet
{
    [actionSheet dismissWithClickedButtonIndex:100 animated:YES];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ABAddressBookRef addressBook = nil;
    
    
    switch (buttonIndex) {
        case 1:
            addressBook = ABAddressBookCreateWithOptions(NULL, nil);
            
            //[self performSelectorOnMainThread:@selector(dismissActionSheet:) withObject:actionSheet waitUntilDone:YES];
            
            __block BOOL accessGranted = NO;
            if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
                //dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    accessGranted = granted;
                    if (accessGranted) {
                        [self continueAddPerson:addressBook];
                    }
                });
                //dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            }
        break;
    }
}

- (void) continueAddPerson: (ABRecordRef) addressBook
{
    ABNewPersonViewController* newPersonVc = [[ABNewPersonViewController alloc] init];
    CFArrayRef array =  ABAddressBookCopyArrayOfAllGroups(addressBook);
    CFIndex numberOfGoups = CFArrayGetCount(array);
    CFStringRef preferedGroupName = CFStringCreateWithCString(kCFAllocatorDefault, GroupName, kCFStringEncodingUTF8);
    
    
    ABRecordRef foundGroup = NULL;
    
    //Trying to find specified group
    
    for (int i =0; i<numberOfGoups; ++i)
    {
        ABRecordRef currentGroup = CFArrayGetValueAtIndex(array, i);
        CFStringRef groupName = ABRecordCopyValue(currentGroup, kABGroupNameProperty);
        
        if (CFStringCompare(groupName, preferedGroupName, 0) == 0)
        {
            foundGroup = currentGroup;
            break;
        }
    }
    
    //If there's no such group then create it ourselves
    
    if (foundGroup == NULL)
    {
        foundGroup = ABGroupCreate();
        ABRecordSetValue(foundGroup, kABGroupNameProperty, preferedGroupName, nil);
        ABAddressBookAddRecord(addressBook, foundGroup, nil);
    }
    
    CFRelease(array);
    CFRelease(preferedGroupName);
    
    
    //Creating person and filling info
    ABRecordRef person = ABPersonCreate();
    ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFTypeRef)(_humanInfo.firstName), nil);
    ABRecordSetValue(person, kABPersonLastNameProperty, CFBridgingRetain(_humanInfo.lastName), nil);
    ABRecordSetValue(person, kABPersonJobTitleProperty, CFBridgingRetain(_humanInfo.postName), nil);
    ABRecordSetValue(person, kABPersonBirthdayProperty, CFBridgingRetain(_humanInfo.birthDate), nil);
    ABPersonSetImageData(person, (__bridge CFDataRef)(UIImagePNGRepresentation(_photoImage.image)), nil);
    
    newPersonVc.displayedPerson = person;
    newPersonVc.addressBook = addressBook;
    newPersonVc.parentGroup = foundGroup;
    newPersonVc.newPersonViewDelegate = self;
    
    UINavigationController* navCont = [[UINavigationController alloc] initWithRootViewController:newPersonVc];
    
    [self presentViewController:navCont animated:YES completion:nil];
}

- (void) newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person
{
    if (person)
    {
        CFErrorRef err = nil;
        
        ABGroupAddMember(newPersonView.parentGroup, person, &err);
        if (!err)
            ABAddressBookSave(newPersonView.addressBook, &err);
        
       // CFRelease(err);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
