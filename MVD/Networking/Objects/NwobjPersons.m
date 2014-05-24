//
//  NwobjPersons.m
//  MVD
//
//  Created by Denis Kurochkin on 26.03.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "NwobjPersons.h"
#import "SBJson.h"
#import "Logger.h"
#import "HumanInformation.h"
#import "BiographyInformation.h"
#import "HumanIncomeInformation.h"
#import "NewsInformation.h"

@implementation NwobjPersons

- (id)init
{
    self = [super init];
    if (self)
    {
        _accessToken = nil;
        _succeeded = NO;
        _resultCode = -1;
        _delegate = nil;
        _personsList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    _accessToken = nil;
    _delegate = nil;
}

- (void) setDelegate:(id<PersonsDelegate>)delegate
{
    if (_delegate == delegate)
        return;
    
    _delegate = nil;
    
    if ( [delegate conformsToProtocol:@protocol(PersonsDelegate)] )
    {
        [Logger log:self method:@"setDelegate" format: @"\n\t Set new delegate"];
        
        _delegate = delegate;
    }
    else
        [Logger log:self method:@"setDelegate" format: @"\n\t New delegate doesn't conform to protocol"];
}

- (void) run: (NSString*) url
{
    // Check input parameters:
    
    
    // Parameters are checked, perform the request:
#ifdef ENABLE_ACCESS_TOKEN_PARAMETER
    NSString *strurl = [NSString stringWithFormat:@"%@/getAllPersons?accessToken=%@",
                        url, _accessToken];
#else
    NSString *strurl = [NSString stringWithFormat:@"%@/getAllPersons",
                        url];
#endif
    
    _exec_url = [NSURL URLWithString:strurl];
    
    [Logger log:self method:@"run" format: @"\n\t %@", strurl];
    
    if ( _exec_url == nil )
        return;
    
    _exec_request = [NSMutableURLRequest requestWithURL:_exec_url];
    [_exec_request setHTTPMethod:@"GET"];
    [_exec_request setHTTPShouldHandleCookies:NO];
    //[_exec_request addValue:[NSString stringWithFormat:@"JSESSIONID=%@", _accessToken] forHTTPHeaderField:@"Cookie"];
    
    assert(_exec_request != nil);
    
    _exec_connection = [[NSURLConnection alloc] initWithRequest:_exec_request delegate:self];
    
    assert(_exec_connection != nil);
    
    [super run:Nil];    // enable network activity indicator
}

- (void) complete: (BOOL) isSuccessfull
{
    [super complete:isSuccessfull];     // disable network activity indicator
    
    _succeeded = isSuccessfull;
    
    _resultCode = -1;
    if ( _succeeded )
    {   // Request successfully performed
        NSString *dataString = [[NSString alloc] initWithData:_exec_data encoding:NSUTF8StringEncoding];
        [Logger log:self method:Nil format:@"TextRepres.: %@", dataString];
        
        // Process results
        // Parse JSON
        
       // NSString *txtFilePath = [[NSBundle mainBundle] pathForResource:@"response" ofType:@"json"];
       // NSString *txtFileContents = [NSString stringWithContentsOfFile:txtFilePath encoding:NSUTF8StringEncoding error:NULL];
       // dataString = txtFileContents;
        
        NSDictionary *result = [dataString JSONValue];
        if ( result )
        {
            if ( [result objectForKey:@"result"] != Nil )
            {
                _resultCode = [[result valueForKey:@"result"] intValue];
                [Logger log:self method:@"complete" format:@"result=%d", _resultCode];
            }
            else
            {
                _resultCode = -1;
                [Logger log:self method:@"complete" format:@"'result' is not found"];
            }
        }
        else
            _resultCode = -2;
        
      //  if ( _resultCode == 0 )
      //  {
            if ( [result objectForKey:@"persons"] != Nil )
            {
                NSArray *persons = [result objectForKey:@"persons"];
                //NSMutableArray *cardNumbers = [[NSMutableArray alloc] init];
                NSEnumerator *enumerator = [persons objectEnumerator];
                NSDictionary *currHumanInfo = Nil;
                while ( (currHumanInfo = (NSDictionary*)[enumerator nextObject]) )
                {
                   HumanInformation *humanInfo = [HumanInformation new];
                    
                id obj = Nil;
                    
                    obj = [currHumanInfo objectForKey:@"f"];
                    if ( obj && [obj isKindOfClass:[NSString class]] )
                        humanInfo.lastName = obj;
                    obj = [currHumanInfo objectForKey:@"i"];
                    if ( obj && [obj isKindOfClass:[NSString class]] )
                        humanInfo.firstName = obj;
                    obj = [currHumanInfo objectForKey:@"o"];
                    if ( obj && [obj isKindOfClass:[NSString class]] )
                        humanInfo.givenName = obj;
                    obj = [currHumanInfo objectForKey:@"post"];
                    if ( obj && [obj isKindOfClass:[NSNumber class]] )
                        humanInfo.post = [obj intValue];
                    obj = [currHumanInfo objectForKey:@"rank"];
                    if ( obj && [obj isKindOfClass:[NSNumber class]] )
                        humanInfo.rank = [obj intValue];
                    obj = [currHumanInfo objectForKey:@"db"];
                    if ( obj && [obj isKindOfClass:[NSString class]] )
                    {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
                        humanInfo.birthDate = [dateFormatter dateFromString:obj];
                    }
                    
                    obj = [currHumanInfo objectForKey:@"photos"];
                    if (obj && [obj isKindOfClass:[NSArray class]])
                        humanInfo.photos = obj;
                    
                    obj = [currHumanInfo objectForKey:@"biography"];
                    if (obj && [obj isKindOfClass:[NSArray class]])
                    {
                        NSMutableArray *biographyObjects = [NSMutableArray new];
                        NSEnumerator *biographyEnumerator = [obj objectEnumerator];
                        NSDictionary * currentDict = nil;
                        while (currentDict = [biographyEnumerator nextObject]) {
                            BiographyInformation *biographyInfo = [BiographyInformation new];
                            obj = [currentDict objectForKey:@"year"];
                            if (obj && [obj isKindOfClass:[NSString class]])
                                biographyInfo.year = [obj intValue];
                            
                            obj = [currentDict objectForKey:@"text"];
                            if (obj && [obj isKindOfClass:[NSString class]])
                                biographyInfo.text = obj;
                            
                            [biographyObjects addObject:biographyInfo];
                        }
                        
                        humanInfo.biography = biographyObjects;
                    }
                    
                    //Human property inforation parsing
                    
                    obj = [currHumanInfo objectForKey:@"property"];
                    if (obj && [obj isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary *propertyDictionary = obj;
                        HumanIncomeInformation *humanIncomeInfo = [HumanIncomeInformation new];
                        
                        obj = [propertyDictionary objectForKey:@"realEstate"];
                        if (obj && [obj isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *realEstateArray = [NSMutableArray new];
                            NSEnumerator *realEstateEnumerator = [realEstateArray objectEnumerator];
                            NSDictionary *currentDict = nil;
                            
                            while (currentDict = [realEstateEnumerator nextObject]) {
                                PropertyInformation *propertyInfo = [PropertyInformation new];
                                obj = [currentDict objectForKey:@"area"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.personValue = [obj doubleValue];
                                obj = [currentDict objectForKey:@"areaWife"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.wifeValue = [obj doubleValue];
                                obj = [currentDict objectForKey:@"year"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.year = [obj unsignedIntValue];
                                
                                [realEstateArray addObject:propertyInfo];
                            }
                            
                            humanIncomeInfo.realEstate = realEstateArray;
                        }
                        
                        obj = [propertyDictionary objectForKey:@"money"];
                        if (obj && [obj isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *moneyArray = [NSMutableArray new];
                            NSEnumerator *moneyEnumerator = [moneyArray objectEnumerator];
                            NSDictionary *currentDict = nil;
                            
                            while (currentDict = [moneyEnumerator nextObject]) {
                                PropertyInformation *propertyInfo = [PropertyInformation new];
                                obj = [currentDict objectForKey:@"sum"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.personValue = [obj doubleValue];
                                obj = [currentDict objectForKey:@"sumWife"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.wifeValue = [obj doubleValue];
                                obj = [currentDict objectForKey:@"year"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.year = [obj unsignedIntValue];
                                
                                [moneyArray addObject:propertyInfo];
                            }
                            
                            humanIncomeInfo.money = moneyArray;
                        }
                        
                        obj = [propertyDictionary objectForKey:@"stead"];
                        if (obj && [obj isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *steadArray = [NSMutableArray new];
                            NSEnumerator *steadEnumerator = [steadArray objectEnumerator];
                            NSDictionary *currentDict = nil;
                            
                            while (currentDict = [steadEnumerator nextObject]) {
                                PropertyInformation *propertyInfo = [PropertyInformation new];
                                obj = [currentDict objectForKey:@"area"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.personValue = [obj doubleValue];
                                obj = [currentDict objectForKey:@"areaWife"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.wifeValue = [obj doubleValue];
                                obj = [currentDict objectForKey:@"year"];
                                if (obj && [obj isKindOfClass:[NSNumber class]])
                                    propertyInfo.year = [obj unsignedIntValue];
                                
                                [steadArray addObject:propertyInfo];
                            }
                            
                            humanIncomeInfo.stead = steadArray;
                        }
                        
                        humanInfo.incomeInformation = humanIncomeInfo;
                    }
                    
                    obj = [currHumanInfo objectForKey:@"news"];
                    if (obj && [obj isKindOfClass:[NSArray class]])
                    {
                        NSArray *newsArray = obj;
                        NSEnumerator *newsEnumerator = [newsArray objectEnumerator];
                        NSDictionary *currentNews = nil;
                        NSMutableArray* news = [NSMutableArray new];
                        
                        while (currentNews = [newsEnumerator nextObject]) {
                            NewsInformation *newsInfo = [NewsInformation new];
                            
                            obj = [currentNews objectForKey:@"text"];
                            if (obj && [obj isKindOfClass:[NSString class]])
                                newsInfo.text = obj;
                            
                            obj = [currentNews objectForKey:@"photo"];
                            if (obj && [obj isKindOfClass:[NSString class]])
                                newsInfo.photo = obj;
                            
                            obj = [currHumanInfo objectForKey:@"date"];
                            if ( obj && [obj isKindOfClass:[NSString class]] )
                            {
                                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                [dateFormatter setDateFormat:@"yyyy.MM.dd"];
                                newsInfo.date = [dateFormatter dateFromString:obj];
                            }
                            
                            [news addObject:newsInfo];
                        }
                        
                        humanInfo.news = news;
                    }
                    
                    
                    
                    
                    [Logger log:self method:@"complete" format:@"\n\tFirst Name=%@\n\tLast Name=%@\n\tGiven Name=%@\n\tRank=%d\n",
                     humanInfo.lastName, humanInfo.firstName, humanInfo.givenName, humanInfo.rank];
                    
                    [_personsList addObject:humanInfo];
                }
                
                //[[NSUserDefaults standardUserDefaults] setObject:cardNumbers forKey:@"cardNumbers"];
                //[cardNumbers release];
            }
            else
            {
                _resultCode = -1;
                [Logger log:self method:@"complete" format:@"'cards' is not found"];
            }
     //   }
        
        dataString = nil;
    }
    
    // Send signal to delegate
    // If delegate is not NIL, it conforms to correct protocol
    if ( _delegate )
        [_delegate personsComplete:_personsList];
}

@end
