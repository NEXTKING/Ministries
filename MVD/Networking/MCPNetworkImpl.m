//
//  MCPNetworkImpl.m
//  MobileBanking
//
//  Created by Denis Kurochkin on 25.03.14.
//  Copyright (c) 2014 BPC. All rights reserved.
//

#import "MCPNetworkImpl.h"
#import "AppDelegate.h"

#import "NwobjPersons.h"
#import "NwobjRanks.h"
#import "NwobjPosts.h"
#import "NwobjImage.h"




@implementation MCPNetworkImpl

@synthesize accessToken = _accessToken;
@synthesize lastResult = _lastResult;

- (id) init
{
    self = [super init];
    
    if ( self )
    {
        [self clearSession];
    }
    
    return self;
}

- (void) dealloc
{
    //[_accessToken release];
    
    //[super dealloc];
}

- (void) clearSession
{
    self.accessToken = @"";
    self.lastResult = 0;
}

- (void) persons:(id<PersonsDelegate>)delegate
{
    NwobjPersons* nwobjPersons = [[NwobjPersons alloc] init];
   // nwobjHello.sessionId = @"SESSID";
    nwobjPersons.delegate = delegate;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [nwobjPersons run:appDelegate.serverAddress];
    
}

- (void) ranks:(id<RanksDelegate>)delegate
{
    NwobjRanks *nwobjRanks = [NwobjRanks new];
    nwobjRanks.delegate = delegate;
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [nwobjRanks run:appDelegate.serverAddress];
    
}

- (void) posts:(id<PostsDelegate>)delegate
{
    NwobjPosts *nwobjPosts = [NwobjPosts new];
    nwobjPosts.delegate = delegate;
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [nwobjPosts run:appDelegate.serverAddress];
    
}

- (void) getImage:(NSString *)imageId reqId:(id)requestId delegate:(id<ResourcesExchangeDelegate>)delegate
{
    NwobjImage *nwobjImage = [NwobjImage new];
    nwobjImage.imageId = imageId;
    nwobjImage.requestId = requestId;
    nwobjImage.delegate = delegate;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [nwobjImage run: appDelegate.serverAddress];
}



@end
