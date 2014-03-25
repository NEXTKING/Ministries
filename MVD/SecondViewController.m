//
//  SecondViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 05.11.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "SecondViewController.h"
#import "HumanInformation.h"
#import "MinistryInformation.h"
#import "HumanCell.h"
#import "HumanViewController.h"
#import "MinistryViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondViewController ()
{
    NSArray *_array;
    NSMutableArray *_humans;
    NSMutableArray *_results;
    NSMutableArray *_sorted;
    NSMutableArray *_splitedArray;
    NSArray *_ministries;
    NSArray *_archive;
    NSArray *_indexArray;
    NSMutableArray *_sortedMinistries;
    NSMutableArray *_sortedArchive;
    BOOL _isEmpty;
    BOOL _emptyString;
    BOOL _controllerIsPushed;
    NSInteger _numberOfFoundSections;
    NSInteger _currentPage;
    CGFloat _currentOffset;
}

@property (nonatomic, strong) UISearchDisplayController *searchController;

@end


@implementation SecondViewController

- (void)viewDidLoad
{
    self.searchController = self.searchDisplayController;
    [super viewDidLoad];
    _currentOffset = 320.0;
    _tabBarPressed = NO;
    _controllerIsPushed = NO;
	// Do any additional setup after loading the view, typically from a nib.
    _array =  [NSArray arrayWithObjects:
     @"Москва",
               @"Центральный ФО",
               @"Дальневосточный ФО",
               @"Приволжский ФО",
               @"Северо-Западный ФО",
               @"Северо-Кавказский ФО",
               @"Сибирский ФО",
               @"Уральский ФО",
               @"Южный ФО",
     @"Адыгея",
     @"Алтай",
     @"Алтайский край",
     @"Амурская область",
     @"Архангельская область",
     @"Астраханская область",
     @"Башкортостан",
     @"Белгородская область",
     @"Брянская область",
     @"Бурятия",
     @"Владимирская область",
     @"Волгоградская область",
     @"Вологодская область",
     @"Воронежская область",
     @"Дагестан",
     @"Еврейская АО",
     @"Забайкальский край",
     @"Ивановская область",
     @"Ингушетия",
     @"Иркутская область",
     @"Кабардино-Балкария",
     @"Калининградская область",
     @"Калмыкия",
     @"Калужская область",
     @"Камчатский край",
     @"Карачаево-Черкесия",
     @"Карелия",
     @"Кемеровская область",
     @"Кировская область",
     @"Коми",
     @"Костромская область",
     @"Краснодарский край",
     @"Красноярский край",
     @"Курганская область",
     @"Курская область",
     @"Ленинградская область",
     @"Липецкая область",
     @"Магаданская область",
     @"Марий Эл",
     @"Мордовия",
     @"Московская область",
     @"Мурманская область",
     @"Ненецкий АО",
     @"Нижегородская область",
     @"Новгородская область",
     @"Новосибирская область",
     @"Омская область",
     @"Оренбургская область",
     @"Орловская область",
     @"Пензенская область",
     @"Пермский край",
     @"Приморский край",
     @"Псковская область",
     @"Ростовская область",
     @"Рязанская область",
     @"Самарская область",
     @"Санкт-Петербург",
     @"Саратовская область",
     @"Саха (Якутия)",
     @"Сахалинская область",
     @"Свердловская область",
     @"Северная Осетия — Алания",
     @"Смоленская область",
     @"Ставропольский край",
     @"Тамбовская область",
     @"Татарстан",
     @"Тверская область",
     @"Томская область",
     @"Тульская область",
     @"Тыва (Тува)",
     @"Тюменская область",
     @"Удмуртия",
     @"Ульяновская область",
     @"Хабаровский край",
     @"Хакасия",
     @"Ханты-Мансийский АО",
     @"Челябинская область",
     @"Чечня",
     @"Чувашия",
     @"Чукотский АО",
     @"Ямало-Ненецкий АО",
     @"Ярославская область", nil];
    
    _sortedMinistries = [[NSMutableArray alloc] init];
    _sortedArchive = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempMinistries = [[NSMutableArray alloc] init];
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"ФСТЭК";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"мид россии.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"МВД России";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"1.png";
        [tempMinistries addObject:ministry];
        
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"МЧС России";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"2.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"МЭР России";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"3.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"МИД России";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"мид россии.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"Минобороны России";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"мид россии.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"Россотрудничество";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"мид россии.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"ФСВТС России";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"мид россии.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"ФСТЭК";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"мид россии.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"МВД России";
        ministry.fullName = @"Министерство внутренних дел Российской Федерации";
        ministry.image = @"1.png";
        [tempMinistries addObject:ministry];
        
    }
    
    _ministries = [NSArray arrayWithArray:tempMinistries];


    
    UIImageView* firstView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    firstView.image = [UIImage imageNamed:@"125.png"];
    firstView.alpha = 1;
     [_scrollview addSubview:firstView];
    firstView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* secondView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*2, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    secondView.image = [UIImage imageNamed:@"2.png"];
    [_scrollview addSubview:secondView];
    secondView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* thirdView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*3, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    thirdView.image = [UIImage imageNamed:@"3.png"];
    [_scrollview addSubview:thirdView];
    thirdView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* fourthView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*4, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    fourthView.image = [UIImage imageNamed:@"мид россии.png"];
    [_scrollview addSubview:fourthView];
    fourthView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* fifthView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*5, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    fifthView.image = [UIImage imageNamed:@"минобороны россии.png"];
    [_scrollview addSubview:fifthView];
    fifthView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* sixthView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*6, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    sixthView.image = [UIImage imageNamed:@"россотрудничество.png"];
    [_scrollview addSubview:sixthView];
    sixthView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* seventh = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*7, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    seventh.image = [UIImage imageNamed:@"фсвтс россии.png"];
    [_scrollview addSubview:seventh];
    seventh.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* eights = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*8, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    eights.image = [UIImage imageNamed:@"фстэк.png"];
    [_scrollview addSubview:eights];
    eights.contentMode = UIViewContentModeScaleAspectFit;
    
    //copied images
    UIImageView* firstCopy = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    firstCopy.image = [UIImage imageNamed:@"фстэк.png"];
    [_scrollview addSubview:firstCopy];
    firstCopy.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* lastCopy = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*9, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    lastCopy.image = [UIImage imageNamed:@"125.png"];
    lastCopy.alpha = 1;
    [_scrollview addSubview:lastCopy];
    lastCopy.contentMode = UIViewContentModeScaleAspectFit;
    
    //UIImageView* fourthView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*3, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    //fourthView.backgroundColor = [UIColor greenColor];
    //[_scrollview addSubview:fourthView];
    
    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(_scrollview.frame.size.width*10, _scrollview.frame.size.height);
    _scrollview.decelerationRate = UIScrollViewDecelerationRateFast;
    [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0) animated:NO];
    
    UITableView *table = self.searchDisplayController.searchResultsTableView;
    table.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    
    [self.searchDisplayController.searchBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0]]];
    [self.searchDisplayController.searchBar setScopeBarBackgroundImage:[self imageWithColor:[UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0]]];
    
    _currentPage = 0;
    
    [_mapImage addSubview:_pointView];
    CGRect frame = _pointView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _pointView.frame = frame;
    
    _humans = [[NSMutableArray alloc] init];
    HumanInformation *h1 = [[HumanInformation alloc] init];
    h1.firstName = @"Иван";
    h1.lastName = @"Петров";
    h1.givenName = @"Иванович";
    h1.rank = @"Генерал-Полковник";
    
    HumanInformation *h2 = [[HumanInformation alloc] init];
    h2.firstName = @"Иван";
    h2.lastName = @"Иванов";
    h2.givenName = @"Дмитриевич";
    h2.rank = @"Генерал-Лейтенант";
    
    HumanInformation *h3 = [[HumanInformation alloc] init];
    h3.firstName = @"Василий";
    h3.lastName = @"Медведев";
    h3.givenName = @"Петрович";
    h3.rank = @"Генерал-Майор";
    
    HumanInformation *h4 = [[HumanInformation alloc] init];
    h4.firstName = @"Дмитрий";
    h4.lastName = @"Минин";
    h4.givenName = @"Константинович";
    h4.rank = @"Генерал-Лейтенант";
    
    HumanInformation *h5 = [[HumanInformation alloc] init];
    h5.firstName = @"Дмитрий";
    h5.lastName = @"Морозов";
    h5.givenName = @"Александрович";
    h5.rank = @"Генерал-Лейтенант";
    
    HumanInformation *h6 = [[HumanInformation alloc] init];
    h6.firstName = @"Иннокентий";
    h6.lastName = @"Филатов";
    h6.givenName = @"Михайлович";
    h6.rank = @"Генерал-Лейтенант";
    
    [_humans addObject:h3];
    [_humans addObject:h1];
    [_humans addObject:h2];
    [_humans addObject:h4];
    [_humans addObject:h5];
    [_humans addObject:h6];
    
    _archive = [NSArray arrayWithArray:_humans];
    
    _sorted = [[NSMutableArray alloc] init];
    _results = [[NSMutableArray alloc] init];
    _splitedArray = [[NSMutableArray alloc] init];
    [self alphabetSplit];
    _isEmpty = YES;
    [__textfield setInputView:_pickeView];
    [__textfield setInputAccessoryView:_toolbar];
    _regionLabel.text = @"";
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void) viewDidAppear:(BOOL)animated
{
    //[__textfield becomeFirstResponder];
}

- (void)convertButtonTitle:(NSString *)from toTitle:(NSString *)to inView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]])
    {
        UIButton *button = (UIButton *)view;
        if ([[button titleForState:UIControlStateNormal] isEqualToString:from])
        {
            [button setTitle:to forState:UIControlStateNormal];
        }
    }
    
    for (UIView *subview in view.subviews)
    {
        [self convertButtonTitle:from toTitle:to inView:subview];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (self.tabBarPressed)
    {
        self.searchDisplayController.active = NO;
        _tabBarPressed = NO;
    }
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(void) dismissActionSheet
{
    
}

#pragma mark - Sorting result arrays

- (void) alphabetSplit
{
    if (_humans.count < 1)
        return;
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for ( HumanInformation *human in _humans )
    {
        if ( human.lastName.length > 0 )
            [set addObject:[human.lastName substringToIndex:1]];
    }
    
    //now we get an array containing all sorted indexes for the table
    _indexArray = [[set allObjects] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    BOOL b = NO;
    [_humans sortUsingFunction:lastNameFirstNameSort context:&b];
    
    NSString *currentLatter = nil;
    NSMutableArray *currentArray = nil;
    
    //let's split humans array onto some alphabetical arrays...
    for (int i = 0; i < _humans.count; ++i)
    {
        HumanInformation *human = _humans[i];
        if (![currentLatter isEqualToString:[human.lastName substringToIndex:1]] || !currentLatter)
        {
            currentLatter = [human.lastName substringToIndex:1];
            if (currentArray.count > 0)
               [_splitedArray addObject:currentArray];
            currentArray = [[NSMutableArray alloc] init];
        }
        
        [currentArray addObject:human];
        if (i == _humans.count-1)
           [_splitedArray addObject:currentArray];
    }
    
    NSMutableArray *s = [[NSMutableArray alloc] initWithArray:_indexArray];
    [s insertObject:UITableViewIndexSearch atIndex:0];
    _indexArray = s;
    
}

- (IBAction)tapGestureHandler:(id) sender
{
    //This is the index of the "page" that we will be landing at
    
    if (_currentOffset == 0)
    {
        [_scrollview scrollRectToVisible:CGRectMake(8*_scrollview.frame.size.width,0,_scrollview.frame.size.width,_scrollview.frame.size.height) animated:NO];
        _currentPage = _ministries.count - 1;
    }
    
    if (sender == _rightTap && _currentPage != _ministries.count - 1)
        _currentPage++;
    else if (sender == _leftTap && _currentPage != 0)
        _currentPage--;
    
    //if (sender == _leftTap && _currentPage == 0)
   // {
   //     [self checkImagesLoop];
   //     _currentPage = _ministries.count-1;
    //}
    
    MinistryInformation *info = _ministries[_currentPage];
    _ministryLabel.text = info.shortName;
    
    
    //This is the actual x position in the scroll view
    
    _currentOffset = _scrollview.contentOffset.x;
    if (sender == _leftTap)
        _currentOffset-=_scrollview.frame.size.width;
    else
        _currentOffset+=_scrollview.frame.size.width;
    
    [_scrollview setContentOffset:CGPointMake(_currentOffset, 0) animated:YES];
    
}



- (void) scrollViewWillEndDragging:(UIScrollView *)scroll withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //This is the index of the "page" that we will be landing at
    NSUInteger nearestIndex = (NSUInteger)(targetContentOffset->x / _scrollview.bounds.size.width + 0.5f);
    
    //Just to make sure we don't scroll past your content
    nearestIndex = MAX( MIN( nearestIndex, 10 ), 0 );
    _currentPage = nearestIndex;
    
    //This is the actual x position in the scroll view
    CGFloat xOffset = nearestIndex * _scrollview.bounds.size.width;
    
    //I've found that scroll views will "stick" unless this is done
    xOffset = xOffset==0?1:xOffset;
    
    //Tell the scroll view to land on our page
    *targetContentOffset = CGPointMake(xOffset, targetContentOffset->y);
    MinistryInformation *info = _ministries[_currentPage];
    _ministryLabel.text = info.shortName;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if( !decelerate )
    {
        NSUInteger currentIndex = (NSUInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width * currentIndex, 0) animated:YES];
    }
}


- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self checkImagesLoop];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self checkImagesLoop];
}

- (void) checkImagesLoop
{
    if (_scrollview.contentOffset.x == 0) {
        // user is scrolling to the left from image 1 to image 10.
        // reposition offset to show image 10 that is on the right in the scroll view
        [_scrollview scrollRectToVisible:CGRectMake(8*_scrollview.frame.size.width,0,_scrollview.frame.size.width,_scrollview.frame.size.height) animated:NO];
        _currentPage = _ministries.count - 1;
        
    }
    else if (_scrollview.contentOffset.x == 9*_scrollview.frame.size.width) {
        // user is scrolling to the right from image 10 to image 1.
        // reposition offset to show image 1 that is on the left in the scroll view
        [_scrollview scrollRectToVisible:CGRectMake(_scrollview.frame.size.width,0,_scrollview.frame.size.width,_scrollview.frame.size.height) animated:NO];
        _currentPage = 0;
    }
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.searchDisplayController.delegate searchDisplayController:self.searchDisplayController shouldReloadTableForSearchString:searchBar.text];
}

#pragma mark - Picker data source

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _array.count;
}


- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.text = _array[row];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

#pragma mark - Table view data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            
            if (_sorted.count == 0)
            {
                if (_sortedMinistries.count == 0)
                    return _sortedArchive.count;
                else
                    return _sortedMinistries.count;
            }
            else
                return _sorted.count;
            
            break;
            
        case 1:
            
            if (_sortedMinistries.count == 0)
                return _sortedArchive.count;
            else
                return _sortedMinistries.count;
            
        case 2:
            return _sortedArchive.count;
            
        default:
            break;
    }
    
    return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //if (_isEmpty)
    //    return _indexArray.count-1;
    NSInteger numberOfSections = 0;
    if (_sorted.count >0)
        numberOfSections ++;
    if (_sortedMinistries.count >0)
        numberOfSections ++;
    if (_sortedArchive.count >0)
        numberOfSections ++;
    
    return numberOfSections;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            
            if (_sorted.count == 0)
            {
                if (_sortedMinistries.count == 0)
                    return @"Архив";
                else
                    return @"Органы власти";
            }
            else
                return @"Персоны";
            
            break;
            
        case 1:
            
            if (_sortedMinistries.count == 0)
                return @"Архив";
            else
                return @"Органы власти";
            
        case 2:
            return @"Архив";
            
        default:
            break;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil)
    {
        HumanCell* humanCell = (HumanCell*)[[[NSBundle mainBundle] loadNibNamed:@"HumanCell" owner:self options:nil] objectAtIndex:0];
        
        id infoObject = nil;
        
        if (indexPath.section == 0)
        {
            if (_sorted.count == 0)
            {
                if (_sortedMinistries.count == 0)
                    infoObject = _sortedArchive[indexPath.row];
                else
                    infoObject = _sortedMinistries[indexPath.row];
            }
            else
                infoObject = [_sorted objectAtIndex:indexPath.row];
        }
        
        if (indexPath.section == 1)
        {
            if (_sortedMinistries.count == 0)
                infoObject = _sortedArchive[indexPath.row];
            else
             infoObject = _sortedMinistries[indexPath.row];
        }
        
        if (indexPath.section == 2)
            infoObject = _sortedArchive[indexPath.row];
            
        
        if ([infoObject isKindOfClass:[HumanInformation class]])
        {
            HumanInformation *human = (HumanInformation*) infoObject;
            humanCell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", human.lastName, human.firstName];
            humanCell.rankLabel.text = human.givenName;
            humanCell.photoView.image = [UIImage imageNamed:@"Путов.jpg"];
            humanCell.photoView.layer.cornerRadius = 30;
            humanCell.photoView.layer.masksToBounds = YES;
        }
        else
        {
            MinistryInformation *minisrty = (MinistryInformation*) infoObject;
            humanCell.photoView.image = [UIImage imageNamed:minisrty.image];
            humanCell.centeralLabel.text = minisrty.shortName;
            humanCell.rankLabel.text = @"";
            humanCell.nameLabel.text = @"";
        }
        
        cell = humanCell;
    }
    
    return cell;
}

#pragma mark - Search control

- (void) processSearch: (NSString*) searchString
{
    [_results removeAllObjects];
    [_sortedMinistries removeAllObjects];
    [_sortedArchive removeAllObjects];
    
    for (HumanInformation *human in _humans)
    {
        //            Logger log:self method:@"Filter Content For Search Text" format:@"pointType = %d, segmentType"
       
        BOOL add_the_record = NO;
        
            NSComparisonResult res_name = [human.firstName compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
            if (res_name == NSOrderedSame)
            {
                add_the_record = YES;
            }
        
        NSComparisonResult res_surname = [human.lastName compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (res_surname == NSOrderedSame)
        {
            add_the_record = YES;
        }
        if ( add_the_record )
        {
            //NSNumber *distance = [NSNumber numberWithInteger:point.distance];
            [_results addObject:human];
        }
    }
    
    for (MinistryInformation* ministry in _ministries)
    {
        //            Logger log:self method:@"Filter Content For Search Text" format:@"pointType = %d, segmentType"
        
        BOOL add_the_record = NO;
        
        NSComparisonResult res_name = [ministry.shortName compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (res_name == NSOrderedSame)
        {
            add_the_record = YES;
        }
        if ( add_the_record )
        {
            //NSNumber *distance = [NSNumber numberWithInteger:point.distance];
            [_sortedMinistries addObject:ministry];
        }
    }

    [_sorted removeAllObjects];
    BOOL b = NO;
    NSArray *sortedArray = [_results sortedArrayUsingFunction:lastNameFirstNameSort context:&b];
    NSArray *foundMinistries = [NSArray arrayWithArray:_sortedMinistries];
    NSArray *sortedMinistries = [foundMinistries sortedArrayUsingFunction: lastNameFirstNameSortMinistry context:&b];
    
    [_sorted insertObjects:sortedArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, sortedArray.count)]];
    [_sortedArchive addObjectsFromArray:_sorted];
    [_sortedMinistries removeAllObjects];
    [_sortedMinistries insertObjects:sortedMinistries atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, sortedMinistries.count)]];
}

NSInteger lastNameFirstNameSort(id person1, id person2, void *reverse)
{
    HumanInformation *human1 = (HumanInformation*)person1;
    HumanInformation *human2 = (HumanInformation*)person2;
    
    NSComparisonResult comparison = [human1.lastName localizedCaseInsensitiveCompare:human2.lastName];
    if (comparison == NSOrderedSame) {
        
        comparison = [human1.firstName localizedCaseInsensitiveCompare:human2.firstName];
    }
    
    if (*(BOOL *)reverse == YES) {
        return 0 - comparison;
    }
    return comparison;
}

NSInteger lastNameFirstNameSortMinistry (id ministry1, id ministry2, void *reverse)
{
    MinistryInformation *min1 = (MinistryInformation*)ministry1;
    MinistryInformation *min2 = (MinistryInformation*)ministry2;
    
    NSComparisonResult comparison = [min1.shortName localizedCaseInsensitiveCompare:min2.shortName];
    if (comparison == NSOrderedSame) {
        
        comparison = [min1.fullName localizedCaseInsensitiveCompare:min2.fullName];
    }
    
    if (*(BOOL *)reverse == YES) {
        return 0 - comparison;
    }
    return comparison;
}


- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isEmpty)
        return _indexArray;
    else
        return nil;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0)
        return 0;
    return index-1;
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //[self.searchDisplayController.searchResultsTableView reloadData];
    // whatever you named your search bar - mine is property named searchBar
    //CGRect testFrame = CGRectMake(0, 20, 320, 100);
    //self.searchDisplayController.searchResultsTableView.frame = testFrame;
    //[self.view addSubview:self.searchDisplayController.searchResultsTableView];
}

- (IBAction)tapHandler:(id)sender
{
    [__textfield becomeFirstResponder];
}

- (BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (_controllerIsPushed)
    {
        _controllerIsPushed = NO;
        return NO;
    }
    return YES;
}

- (IBAction)scrllTapHandler:(id)sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    MinistryViewController *ministry = [MinistryViewController new];
    [self.navigationController pushViewController:ministry animated:YES];
    ministry = nil;
}

- (IBAction)doneButtonHandler:(id)sender
{
    [__textfield resignFirstResponder];
    NSInteger row = [_pickeView selectedRowInComponent:0];
    NSString *title = _array[row];
    _regionLabel.text = title;
    
    MinistryViewController *ministry = [MinistryViewController new];
    [self.navigationController pushViewController:ministry animated:YES];
    ministry.region = title;
    ministry = nil;
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //[self filterContentForSearchText:searchString scope:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
    
    // Return YES to cause the search result table view to be reloaded.
    if (![searchString isEqualToString:@" "])
        _isEmpty = NO;
    if ([searchString isEqualToString:@""])
        _emptyString = YES;
    else
        _emptyString = NO;
    
    [self processSearch: searchString];
    return YES;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // if (!_isEmpty && indexPath.section == 1)
   // {
   //     MinistryViewController *ministry = [[MinistryViewController alloc] init];
   //     [self.navigationController pushViewController:ministry animated:YES];
   // }
    if (indexPath.section == 0 && _sorted.count > 0)
    {
        [self performSegueWithIdentifier:@"PushHuman" sender:nil];
        _controllerIsPushed = YES;
    }
    else
    {
        MinistryViewController *minVC = [[MinistryViewController alloc] init];
        [self.navigationController pushViewController:minVC animated:YES];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    //[self.view insertSubview:tableView belowSubview:_pageControl];
}

- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    controller.searchResultsTableView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    
}


- (void) searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    if (_isEmpty || !_emptyString)
        return;
    
    //_isEmpty = YES;
   //[controller.searchBar.delegate searchBar:controller.searchBar textDidChange:@" "];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    //j[self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:searchOption];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}



@end
