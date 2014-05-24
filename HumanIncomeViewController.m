//
//  HumanIncomeViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 26.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "HumanIncomeViewController.h"
#import "CommonInfoCell.h"
#import "HumanIncomeInformation.h"

const NSInteger realEstateHeight = 62;
const NSInteger moneyHeight = 120;
const NSInteger steadHeight = 62;

@interface HumanIncomeViewController ()
{
    BOOL _isRightSwiped;
    double __realEstateMaximum;
    double __moneyMaximum;
    double __steadMaximum;
    NSUInteger __numberOfPages;
    NSUInteger _currentPage;
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
    
    _personNameLabel.text = [NSString stringWithFormat:@"- %@ %@.%@.", _humanInfo.lastName, [_humanInfo.firstName substringToIndex:1], [_humanInfo.givenName substringToIndex:1]];
    
    self.title = @"Доходы";
    __realEstateMaximum = 0.0;
    __moneyMaximum = 0.0;
    __steadMaximum = 0.0;
    [self estimateUpperEdges];
    
    HumanIncomeInformation* incomeInfo = _humanInfo.incomeInformation;
    
    NSMutableArray *estateArray = [NSMutableArray arrayWithArray:incomeInfo.realEstate];
    if (estateArray && estateArray.count > 0)
    {
        PropertyInformation *info = [estateArray lastObject];
        _rightYearLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)info.year];
        [estateArray removeLastObject];
    }
    
    if (estateArray && estateArray.count > 0)
    {
        PropertyInformation *info = [estateArray lastObject];
        _middleYearLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)info.year];
        [estateArray removeLastObject];
    }
    
    if (estateArray && estateArray.count > 0)
    {
        PropertyInformation *info = [estateArray lastObject];
        _leftYearLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)info.year];
        [estateArray removeLastObject];
    }
    
    estateArray = nil;
    
    __numberOfPages = MAX(incomeInfo.realEstate.count - 2, 0);
    _currentPage = __numberOfPages - 1;
    
    //[self setNewValuesAtPage:_currentPage animated:NO];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidLayoutSubviews
{
    [self setNewValuesAtPage:_currentPage animated:NO];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) estimateUpperEdges
{
    //estimating the maximum rates of main properties
    
    for (PropertyInformation *propertyInfo in _humanInfo.incomeInformation.realEstate)
    {
        double sum = propertyInfo.personValue + propertyInfo.wifeValue;
        if (sum > __realEstateMaximum)
            __realEstateMaximum = sum;
    }
    
    for (PropertyInformation *propertyInfo in _humanInfo.incomeInformation.money)
    {
        double sum = propertyInfo.personValue + propertyInfo.wifeValue;
        if (sum > __moneyMaximum)
            __moneyMaximum = sum;
    }
    
    for (PropertyInformation *propertyInfo in _humanInfo.incomeInformation.stead)
    {
        double sum = propertyInfo.personValue + propertyInfo.wifeValue;
        if (sum > __steadMaximum)
            __steadMaximum = sum;
    }
}

- (void) setNewValuesAtPage: (NSUInteger) page animated: (BOOL) animated
{
    HumanIncomeInformation *incomeInfo = _humanInfo.incomeInformation;
    
    //Money
    
    [self animateSection:_moneyLeftMan wifeChart:_moneyLeftWife gradeLabel:_moneyLableLeft propertyInfo:incomeInfo.money[page] animated:animated];
    [self animateSection:_moneyMiddleMan wifeChart:_moneyMiddleWife gradeLabel:_moneyLabelMiddle propertyInfo:incomeInfo.money[page + 1] animated:animated];
    [self animateSection:_moneyRightMan wifeChart: _moneyRightWife gradeLabel:_moneyLabelRight propertyInfo:incomeInfo.money[page+2] animated:animated];
    
    // Real Estate
    
    [self animateSection:_estateLeftMan wifeChart:_estateLeftWife gradeLabel:_estateLabelLeft propertyInfo:incomeInfo.realEstate[page] animated:animated];
    [self animateSection:_estateMiddleMan wifeChart:_estateMiddleWife gradeLabel:_estateLabelMiddle propertyInfo:incomeInfo.realEstate[page + 1] animated:animated];
    [self animateSection:_estateRightMan wifeChart:_estateRightWife gradeLabel:_estateLabelRight propertyInfo:incomeInfo.realEstate[page + 2] animated:animated];
    
    //Stead
    
    [self animateSection:_steadLeftMan wifeChart:_steadLeftWife gradeLabel:_steadLabelLeft propertyInfo:incomeInfo.stead[page] animated:animated];
    [self animateSection:_steadMiddleMan wifeChart:_steadMiddleWife gradeLabel:_steadLabelMiddle propertyInfo:incomeInfo.stead[page + 1] animated:animated];
    [self animateSection:_steadRightMan wifeChart:_steadRightWife gradeLabel:_steadLabelRight propertyInfo:incomeInfo.stead[page +2] animated:animated];
    
}


- (IBAction)leftSwipeSelector:(UISwipeGestureRecognizer*) sender
{
    if (_currentPage == __numberOfPages - 1)
        return;
    
    _currentPage++;
    
    NSInteger year = [_leftYearLabel.text intValue];
    _leftYearLabel.text = [NSString stringWithFormat:@"%ld", (long)year+1];
    _middleYearLabel.text = [NSString stringWithFormat:@"%ld", (long)year+2];
    _rightYearLabel.text = [NSString stringWithFormat:@"%ld", (long)year+3];
    
    [self setNewValuesAtPage:_currentPage animated:YES];
    
}

- (IBAction)rightSwipeSelector:(UISwipeGestureRecognizer *)sender
{
    if (_currentPage == 0)
        return;
    
    _currentPage--;
    
    NSInteger year = [_leftYearLabel.text intValue];
    _leftYearLabel.text = [NSString stringWithFormat:@"%ld", (long)year-1];
    _middleYearLabel.text = [NSString stringWithFormat:@"%ld", (long)year];
    _rightYearLabel.text = [NSString stringWithFormat:@"%ld", (long)year+1];
    
   [self setNewValuesAtPage:_currentPage animated:YES];
    
    //[self animateCharts:sender.direction];
}



- (void) animateSection: (UIView*) personChart wifeChart: (UIView*) wifeChart gradeLabel: (UILabel*) gradeLabel propertyInfo: (PropertyInformation*) info animated: (BOOL) animated
{
    double maximumChartHeight = 0.0f;
    double maximumPropertyValue = 0.0f;
    NSString *dimensionString = nil;
    
    if (personChart == _moneyMiddleMan || personChart == _moneyLeftMan || personChart == _moneyRightMan)
    {
        maximumChartHeight      = moneyHeight;
        maximumPropertyValue    = __moneyMaximum;
        dimensionString = @"млн. руб.";
    }
    else if (personChart == _estateMiddleMan || personChart == _estateLeftMan || personChart == _estateRightMan)
    {
        maximumChartHeight      = realEstateHeight;
        maximumPropertyValue    = __realEstateMaximum;
        dimensionString = @"кв. м.";
    }
    else if (personChart == _steadLeftMan || personChart == _steadMiddleMan || personChart == _steadRightMan)
    {
        maximumChartHeight      = steadHeight;
        maximumPropertyValue    = __steadMaximum;
        dimensionString = @"кв. м.";
    }
    
    
    CGFloat manNewHeight = (info.personValue * maximumChartHeight)/maximumPropertyValue;
    CGFloat wifeNewHeight = (info.wifeValue * maximumChartHeight)/maximumPropertyValue;
    
    CGFloat wifeChartDelta = personChart.frame.size.height - manNewHeight;
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *value = [formatter stringFromNumber:[NSNumber numberWithFloat:info.personValue + info.wifeValue]];
    
    
    gradeLabel.text = [NSString stringWithFormat:@"%@ %@", value, dimensionString];
    
    //Animation block
    
    void (^animationBlock)();
    animationBlock=^{
        CGRect manFrame = personChart.frame;
        CGRect wifeFrame = wifeChart.frame;
        CGRect gradeFrame = gradeLabel.frame;
        
        gradeFrame.origin.y +=  (wifeFrame.size.height -wifeNewHeight) + (manFrame.size.height - manNewHeight);
        
        manFrame.origin.y += manFrame.size.height - manNewHeight;
        manFrame.size.height = manNewHeight;
        
        wifeFrame.origin.y += wifeFrame.size.height -wifeNewHeight;
        wifeFrame.size.height = wifeNewHeight;
        wifeFrame.origin.y += wifeChartDelta;
        
        [personChart setFrame:manFrame];
        [wifeChart   setFrame:wifeFrame];
        [gradeLabel  setFrame:gradeFrame];
    };
    
    if (animated) {
        [UIView animateWithDuration:0.4 animations:animationBlock completion:^(BOOL finished) {
            
        }];
    }else{
        animationBlock();
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
