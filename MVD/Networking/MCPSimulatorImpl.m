
//
//  MCPSimulatorImpl.m
//  MobileBanking
//
//  Created by power on 15.04.13.
//  Copyright (c) 2013 BPC. All rights reserved.
//

#import "MCPSimulatorImpl.h"
#import "AppDelegate.h"
#import "MCProtocol.h"
#import "HumanInformation.h"
#import "HumanIncomeInformation.h"
#import "NewsInformation.h"


#import "Logger.h"


#ifndef DEBUG
static const double _network_delay = 1.0;
#else
static const double _network_delay = 1.0;
#endif

static int __getImage_counter = 1;


@interface MCPSimulatorImpl()
{
    HumanInformation *humanInfo;
}

- (void) generateData;
- (void) destroyData;

@end

@implementation MCPSimulatorImpl

@synthesize accessToken = _accessToken;
@synthesize lastResult = _lastResult;

- (id) init
{
    self = [super init];
    
    if ( self )
    {
        [self clearSession];
        srand((int)self);
        [self generateData];
    }
    
    return self;
}



- (void) enableNetworkActivityIndicator:(BOOL)enable
{
    if ( [[[UIApplication sharedApplication] delegate] isKindOfClass:[AppDelegate class]] )
    {
        AppDelegate* appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        if ( enable )
        {   // enable network activity indicator
            [appDelegate enableNetworkIndicator];
        }
        else
        {   // disable network activity indicator
            [appDelegate disableNetworkIndicator];
        }
    }
}


- (NSDate*) dateFromString:(NSString*)string
{
    // string format: YYYYMMDDHHMISS
    struct tm timestamp;
    memset(&timestamp, 0, sizeof(timestamp));
    timestamp.tm_year = [[string substringWithRange:NSMakeRange(0, 4)] intValue] - 1900;
    timestamp.tm_mon = [[string substringWithRange:NSMakeRange(4, 2)] intValue] - 1;
    timestamp.tm_mday = [[string substringWithRange:NSMakeRange(6, 2)] intValue];
    timestamp.tm_hour = [[string substringWithRange:NSMakeRange(8, 2)] intValue];
    timestamp.tm_min = [[string substringWithRange:NSMakeRange(10, 2)] intValue];
    timestamp.tm_sec = [[string substringWithRange:NSMakeRange(12, 2)] intValue];
    //timestamp.tm_gmtoff = 0;
    //timestamp.tm_isdst = 0;
    //timestamp.tm_wday = -1;
    //timestamp.tm_yday = -1;
    
    return [NSDate dateWithTimeIntervalSince1970:mktime(&timestamp)];
}

- (void) generateData
{//
    humanInfo = [HumanInformation new];
    humanInfo.firstName = @"Александр";
    humanInfo.lastName = @"Колокольцев";
    
    HumanIncomeInformation *incomeInfo = [HumanIncomeInformation new];
    
    NSMutableArray *realEstateArray = [NSMutableArray new];
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 636;
        propertyInfo.wifeValue = 86;
        propertyInfo.year = 2010;
        [realEstateArray addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 636;
        propertyInfo.wifeValue = 86;
        propertyInfo.year = 2011;
        [realEstateArray addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 636;
        propertyInfo.wifeValue = 172;
        propertyInfo.year = 2012;
        [realEstateArray addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 780;
        propertyInfo.wifeValue = 100;
        propertyInfo.year = 2013;
        [realEstateArray addObject:propertyInfo];
    }
    
    incomeInfo.realEstate = realEstateArray;
    
    NSMutableArray *money = [NSMutableArray new];
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 1.7;
        propertyInfo.wifeValue = 0.4;
        propertyInfo.year = 2010;
        [money addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 1.8;
        propertyInfo.wifeValue = 0.4;
        propertyInfo.year = 2011;
        [money addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 5.6;
        propertyInfo.wifeValue = 0.4;
        propertyInfo.year = 2012;
        [money addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 6.2;
        propertyInfo.wifeValue = 0.4;
        propertyInfo.year = 2013;
        [money addObject:propertyInfo];
    }
    
    incomeInfo.money = money;
    
    NSMutableArray *stead = [NSMutableArray new];
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 679;
        propertyInfo.wifeValue = 600;
        propertyInfo.year = 2010;
        [stead addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 679;
        propertyInfo.wifeValue = 600;
        propertyInfo.year = 2011;
        [stead addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 679;
        propertyInfo.wifeValue = 455;
        propertyInfo.year = 2012;
        [stead addObject:propertyInfo];
    }
    
    {
        PropertyInformation *propertyInfo = [PropertyInformation new];
        propertyInfo.personValue = 579;
        propertyInfo.wifeValue = 455;
        propertyInfo.year = 2013;
        [stead addObject:propertyInfo];
    }
    
    incomeInfo.stead = stead;
    
    humanInfo.incomeInformation = incomeInfo;
    
    NSMutableArray *newsArray = [NSMutableArray new];
    
    NewsInformation *newsInfo = [NewsInformation new];
    newsInfo.date = [NSDate dateWithTimeInterval:0.0 sinceDate:[NSDate date]];
    newsInfo.text = @"В свою очередь газета \"Ведомости\" сообщает со ссылкой на сотрудника в аппарате правительства, что неформальные контакты с компанией Visa продолжаются, и ее представители в целом готовы продолжить работу в России, но в публичном пространстве намерены жестко критиковать затрагивающие ее нововведения российского законодательства.";
    [newsArray addObject:newsInfo];
    
    humanInfo.news = newsArray;
    
}


- (void) persons:(id<PersonsDelegate>)delegate
{
    [self performSelector:@selector(delayedPersonsComplete:) withObject:delegate afterDelay:_network_delay];
}

- (void) delayedPersonsComplete: (id<PersonsDelegate>) delegate
{
    if (delegate)
        [delegate personsComplete:[NSArray arrayWithObject:humanInfo]];
}

- (void) ranks:(id<RanksDelegate>)delegate
{
    if (delegate)
        [delegate ranksComplete:nil];
}

- (void) posts:(id<PostsDelegate>)delegate
{
    if (delegate)
        [delegate postsComplete:nil];
}

- (void) clearSession
{
    self.accessToken = @"";
    self.lastResult = 0;
}

@end
