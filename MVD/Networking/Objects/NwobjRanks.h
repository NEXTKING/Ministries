//
//  NwobjRanks.h
//  MVD
//
//  Created by Denis Kurochkin on 24.04.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "NwObject.h"
#import "MCProtocol.h"

@interface NwobjRanks : NwObject

{
@protected NSMutableDictionary *_ranksDict;
}

- (void) run: (const NSString*) url;
- (void) complete: (BOOL) isSuccessfull;

@property (nonatomic, readwrite, retain) id <RanksDelegate> delegate;

// input parameters:
@property (readwrite, copy) NSString* accessToken;

// result parameters:
@property (readonly, getter = isSucceeded, assign) BOOL succeeded;
@property (readonly, assign) int resultCode;
@property (readonly, retain) NSDictionary* ranksDict;

@end
