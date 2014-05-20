//
//  NwobjImage.h
//  MVD
//
//  Created by Denis Kurochkin on 12.05.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "NwObject.h"
#import "MCProtocol.h"

@interface NwobjImage : NwObject

- (void) run: (const NSString*) url;
- (void) complete: (BOOL) isSuccessfull;

@property (nonatomic, readwrite, retain) id <ResourcesExchangeDelegate> delegate;

// input parameters:
@property (readwrite, copy) NSString* accessToken;
@property (readwrite, copy) NSString* imageId;
@property (readwrite, retain) id requestId;

// result parameters:
@property (readonly, getter = isSucceeded, assign) BOOL succeeded;
@property (readonly, assign) int resultCode;
@property (readonly, retain) UIImage *imageData;

@end
