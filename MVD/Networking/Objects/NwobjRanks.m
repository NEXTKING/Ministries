//
//  NwobjRanks.m
//  MVD
//
//  Created by Denis Kurochkin on 24.04.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "NwobjRanks.h"
#import "Logger.h"
#import "SBJson.h"
#import "HumanRankParameters.h"

@implementation NwobjRanks

- (id)init
{
    self = [super init];
    if (self)
    {
        _accessToken = nil;
        _succeeded = NO;
        _resultCode = -1;
        _delegate = nil;
        _ranksDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    _accessToken = nil;
    _delegate = nil;
}

- (void) setDelegate:(id<RanksDelegate>)delegate
{
    if (_delegate == delegate)
        return;
    
    _delegate = nil;
    
    if ( [delegate conformsToProtocol:@protocol(RanksDelegate)] )
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
    NSString *strurl = [NSString stringWithFormat:@"%@/getAllRanks?accessToken=%@",
                        url, _accessToken];
#else
    NSString *strurl = [NSString stringWithFormat:@"%@/getAllRanks",
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
        if ( [result objectForKey:@"ranks"] != Nil )
        {
            NSArray *persons = [result objectForKey:@"ranks"];
            //NSMutableArray *cardNumbers = [[NSMutableArray alloc] init];
            NSEnumerator *enumerator = [persons objectEnumerator];
            NSDictionary *currHumanInfo = Nil;
            while ( (currHumanInfo = (NSDictionary*)[enumerator nextObject]) )
            {
                HumanRankParameters *rankParams = [HumanRankParameters new];
                
                id obj = Nil;

                obj = [currHumanInfo objectForKey:@"id"];
                if ( obj && [obj isKindOfClass:[NSNumber class]] )
                    rankParams.rankId = [obj intValue];
                obj = [currHumanInfo objectForKey:@"rank"];
                if ( obj && [obj isKindOfClass:[NSString class]] )
                    rankParams.rankName = obj;
                
                
                [Logger log:self method:@"complete" format:@"\n\tRank_id=%d\n\tRank name=%@\n\t",
                 rankParams.rankId, rankParams.rankName];
                
                [_ranksDict setObject:rankParams.rankName forKey:[NSNumber numberWithInt:rankParams.rankId]];
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
        [_delegate ranksComplete:_ranksDict];
}





@end
