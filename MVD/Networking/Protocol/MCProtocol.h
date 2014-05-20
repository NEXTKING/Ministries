//
//  MCProtocol.h
//  MobileBanking
//
//  Created by Sergey Sasin on 15.04.13.
//  Copyright (c) 2013 BPC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Delegates.h"

@protocol MCProtocol <NSObject>

// Session management
@required
- (NSString*)   accessToken;
- (void)        setAccessToken:(NSString*)token;
- (int)         lastResult;
- (void)        setLastResult:(int)result;
- (void)        clearSession;
   
// Functions
@required
- (void) persons:(id<PersonsDelegate>) delegate;
- (void) ranks: (id<RanksDelegate>) delegate;
- (void) posts: (id<PostsDelegate>) delegate;
- (void) getImage: (NSString*)imageId reqId:(id)requestId delegate:(id<ResourcesExchangeDelegate>)delegate;
@end
