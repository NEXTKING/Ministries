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
    NSDictionary *_ranks;
    NSDictionary *_posts;
    
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
    BOOL _scrollViewHaveDragged;
    NSInteger _numberOfFoundSections;
    NSInteger _currentPage;
    NSInteger _currentTapPage;
    CGFloat _currentOffset;
    
    NSUInteger __requestCount;
}

@property (nonatomic, strong) UISearchDisplayController *searchController;

@end


@implementation SecondViewController

- (void) personsComplete:(NSArray *)persons
{
    if (persons && persons.count > 0)
    {
        _humans = [[NSMutableArray alloc] initWithArray:persons];
        _archive  = [NSArray arrayWithArray:_humans];
        [_loadingActivity stopAnimating];
        _loadingView.hidden = YES;
    }
}

- (void) ranksComplete:(NSDictionary *)ranks
{
    if (ranks)
    {
        _ranks = [[NSDictionary alloc] initWithDictionary:ranks];
    }
        
}

- (void) postsComplete:(NSDictionary *)posts
{
    if (posts)
    {
        _posts = [[NSDictionary alloc] initWithDictionary:posts];
    }
}

- (void) getImageComplete:(int)result image:(UIImage *)image imgId:(NSString*)imageId reqId:(id)requestId
{
    if ( image && requestId )
    {
        NSIndexPath *indexPath = (NSIndexPath*)requestId;
        if ( [indexPath indexAtPosition:2] == __requestCount )
        {
            NSIndexPath *index = [NSIndexPath indexPathForRow:[indexPath indexAtPosition:0] inSection:0];
            HumanInformation *info = [_sorted objectAtIndex:[indexPath indexAtPosition:0]];
            info.image = image;
            
            [self.searchDisplayController.searchResultsTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (void)viewDidLoad
{
    //NETWORKING!!
    
    
    
    [[MCPServer instance] persons:self];
    [_loadingActivity startAnimating];
    [[MCPServer instance] ranks:self];
    [[MCPServer instance] posts:self];
    
    
    //NETWORKING !!!
    
    
    self.searchController = self.searchDisplayController;
    [super viewDidLoad];
    _currentOffset = 320.0;
    __requestCount = 0;
    _tabBarPressed = NO;
    _controllerIsPushed = NO;
	// Do any additional setup after loading the view, typically from a nib.
    _array =  [NSArray arrayWithObjects:
     @"Москва",
               @"Центральный ФО",
               @"Дальневосточный ФО",
               @"Крымский ФО",
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
     @"Крым",
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
     @"Севастополь",
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
        ministry.shortName = @"ФТС России";
        ministry.fullName = @"Федеральная Таможенная служба Российской Федерации";
        ministry.image = @"фтс.png";
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
        ministry.shortName = @"Ген. прокуратура РФ";
        ministry.fullName = @"Генеральная прокуратура Российской Федерации";
        ministry.image = @"ген прокуратура.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"След. коммитет РФ";
        ministry.fullName = @"Следственный коммитет Российской Федерации";
        ministry.image = @"следственный коммитет.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"ФСКН России";
        ministry.fullName = @"Федеральная служба Российской Федерации по контролю за оборотом наркотиков";
        ministry.image = @"фскн1.png";
        [tempMinistries addObject:ministry];
    }
    
    {
        MinistryInformation *ministry = [[MinistryInformation alloc] init];
        ministry.shortName = @"ФТС России";
        ministry.fullName = @"Федеральная Таможенная служба Российской Федерации";
        ministry.image = @"фтс.png";
        [tempMinistries addObject:ministry];
    }
    
    /* {
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
    } */
    
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
    secondView.image = [UIImage imageNamed:@"ген прокуратура.png"];
    [_scrollview addSubview:secondView];
    secondView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIImageView* thirdView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*3, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    thirdView.image = [UIImage imageNamed:@"следственный коммитет.png"];
    [_scrollview addSubview:thirdView];
    thirdView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* fourthView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*4, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    fourthView.image = [UIImage imageNamed:@"фскн1.png"];
    [_scrollview addSubview:fourthView];
    fourthView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* fifthView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*5, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    fifthView.image = [UIImage imageNamed:@"фтс.png"];
    [_scrollview addSubview:fifthView];
    fifthView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    //copied images
    UIImageView* firstCopy = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    firstCopy.image = [UIImage imageNamed:@"фтс.png"];
    [_scrollview addSubview:firstCopy];
    firstCopy.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* lastCopy = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*6, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    lastCopy.image = [UIImage imageNamed:@"125.png"];
    lastCopy.alpha = 1;
    [_scrollview addSubview:lastCopy];
    lastCopy.contentMode = UIViewContentModeScaleAspectFit;
    
    //UIImageView* fourthView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width*3, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
    //fourthView.backgroundColor = [UIColor greenColor];
    //[_scrollview addSubview:fourthView];
    
    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(_scrollview.frame.size.width*7, _scrollview.frame.size.height);
    _scrollview.decelerationRate = UIScrollViewDecelerationRateFast;
    [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0) animated:NO];
    
    UITableView *table = self.searchDisplayController.searchResultsTableView;
    table.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    
    [self.searchDisplayController.searchBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0]]];
    [self.searchDisplayController.searchBar setScopeBarBackgroundImage:[self imageWithColor:[UIColor colorWithRed:51.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0]]];
    
    _currentPage = 1;
    _currentTapPage = 1;
    
    [_mapImage addSubview:_pointView];
    CGRect frame = _pointView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _pointView.frame = frame;
    
    
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
    CGFloat pageWidth = _scrollview.frame.size.width;
    float fractionalPage = _scrollview.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    
    if (_scrollViewHaveDragged)
    {
        _currentTapPage = page;
        _scrollViewHaveDragged = NO;
    }
    
    if (sender == _leftTap)
    {
        //prevPage --;
        _currentTapPage --;
        if (_currentTapPage < 0 )
        {
            _currentTapPage = _ministries.count - 3;
            
           // CGFloat deltaOffset = abs(320 - _scrollview.contentOffset.x);
            CGFloat requiredOffset = _scrollview.contentSize.width - 2*_scrollview.frame.size.width;
            [_scrollview setContentOffset:CGPointMake(requiredOffset, 0)];
        }

        _currentOffset =(_currentTapPage)*_scrollview.frame.size.width;
        [_scrollview setContentOffset:CGPointMake(_currentOffset, 0) animated:YES];
        
    }
    else
    {
        _currentTapPage ++;
        if (_currentTapPage > _ministries.count - 1)
        {
            _currentTapPage = 2;
            CGFloat requiredOffset = _scrollview.bounds.size.width;
            [_scrollview setContentOffset:CGPointMake(requiredOffset, 0)];
        }
            _currentOffset =(_currentTapPage)*_scrollview.frame.size.width;
            [_scrollview setContentOffset:CGPointMake(_currentOffset, 0) animated:YES];
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _scrollViewHaveDragged = YES;
}



- (void) scrollViewWillEndDragging:(UIScrollView *)scroll withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //This is the index of the "page" that we will be landing at
   // NSUInteger nearestIndex = (NSUInteger)(targetContentOffset->x  / _scrollview.bounds.size.width);
    
    
    //Just to make sure we don't scroll past your content
    //nearestIndex = MAX( MIN( nearestIndex, 6 ), 0 );
    
    //if (nearestIndex == 0)
    //    _currentPage = 5;
    //else if (nearestIndex == 6)
    //    _currentPage = 1;
    
    //This is the actual x position in the scroll view
   // CGFloat xOffset = nearestIndex * _scrollview.bounds.size.width;
    
    //I've found that scroll views will "stick" unless this is done
   // xOffset = xOffset==0?1:xOffset;
    
    //Tell the scroll view to land on our page
    //*targetContentOffset = CGPointMake(xOffset, targetContentOffset->y);
    //MinistryInformation *info = _ministries[_currentPage];
    //_ministryLabel.text = info.shortName;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //if( !decelerate )
    //{
    //    NSUInteger currentIndex = (NSUInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
    //    [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width * currentIndex, 0) animated:YES];
    //}
}


- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // [self checkImagesLoop];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.searchDisplayController.isActive)
        return;
    
    static NSInteger previousPage = 1;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    
    
    if (previousPage != page) {
        previousPage = page;
        
        _currentPage = page;
        
        if (_currentTapPage != _currentPage)
            _currentPage = _currentTapPage;
        
        MinistryInformation *info = _ministries[page];
        _ministryLabel.text = info.shortName;
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
            humanCell.photoView.layer.cornerRadius = 30;
            humanCell.photoView.layer.masksToBounds = YES;
            humanCell.photoView.image = human.image;
            
            NSUInteger indexesID[] = {indexPath.row, 0, __requestCount};
            NSIndexPath *indexPathID =  [NSIndexPath indexPathWithIndexes:indexesID length:3];
            
            NSArray *indexes = [tableView indexPathsForVisibleRows];
            for (NSIndexPath *index in indexes) {
                if (index.row == indexPath.row) {
                    if (!human.image && human.photos && human.photos.count>0)
                        [[MCPServer instance] getImage:human.photos[0] reqId:indexPathID delegate:self];
                }
            }
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
    __requestCount++;
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
    
    for (NSUInteger i =0; i < _sorted.count; ++i)
    {
        //HumanInformation *info = _sorted[i];
        
        //if (info.photos && info.photos.count > 0 && !info.image)
        //    [[MCPServer instance] getImage:info.photos[0] reqId:indexPath delegate:self];
    }
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
    
    if (![searchString isEqualToString:@""])
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
        [self performSegueWithIdentifier:@"PushHuman" sender:indexPath];
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
    
    if ([[segue identifier] isEqualToString:@"PushHuman"])
    {
        // Get reference to the destination view controller
        HumanViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        NSIndexPath *indexPath = (NSIndexPath*) sender;
        HumanInformation *selectedHuman = _sorted[indexPath.row];
        selectedHuman.rankName = [_ranks objectForKey:[NSNumber numberWithInt:selectedHuman.rank]];
        selectedHuman.postName = [_posts objectForKey:[NSNumber numberWithInt:selectedHuman.post]];
        vc.humanInfo = selectedHuman;
        vc.photoImage.image = selectedHuman.image;
    }
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
