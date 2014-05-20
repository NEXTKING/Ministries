//
//  NwobjPersons.h
//  MVD
//
//  Created by Denis Kurochkin on 26.03.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "NwObject.h"
#import "MCProtocol.h"

@interface NwobjPersons : NwObject

{
@protected NSMutableArray *_personsList;
}

- (void) run: (const NSString*) url;
- (void) complete: (BOOL) isSuccessfull;

@property (nonatomic, readwrite, retain) id <PersonsDelegate> delegate;

// input parameters:
@property (readwrite, copy) NSString* accessToken;

// result parameters:
@property (readonly, getter = isSucceeded, assign) BOOL succeeded;
@property (readonly, assign) int resultCode;
@property (readonly, retain) NSArray* personsList;

@end
