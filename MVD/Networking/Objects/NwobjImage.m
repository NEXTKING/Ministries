//
//  NwobjImage.m
//  MVD
//
//  Created by Denis Kurochkin on 12.05.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "NwobjImage.h"
#import "Logger.h"

@implementation NwobjImage

- (id)init
{
    self = [super init];
    if (self)
    {
        _accessToken = nil;
        _imageId = nil;
        _requestId = nil;
        _succeeded = NO;
        _resultCode = -1;
        _delegate = nil;
        _imageData = nil;
    }
    return self;
}


- (void) setDelegate:(id<ResourcesExchangeDelegate>)delegate
{
    if (_delegate == delegate)
        return;
    
    _delegate = nil;
    
    if ( [delegate conformsToProtocol:@protocol(ResourcesExchangeDelegate)] )
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
  
    if ( _imageId == Nil )
    {
        [Logger log:self method:@"run" format:@"'imageId' property is not set"];
        [self complete:NO];
        return;
    }
    
    // Parameters are checked, perform the request:
#ifdef ENABLE_ACCESS_TOKEN_PARAMETER
    NSString *strurl = [NSString stringWithFormat:@"%@/getImage?accessToken=%@&resid=%@",
                        url, _accessToken, [self percentEncode:_imageId]];
#else
   // NSString *strurl = [NSString stringWithFormat:@"%@/getImage?resid=%@",
                       // url, [self percentEncode:_imageId]];
    NSString *strurl = [NSString stringWithString:_imageId];
#endif
    
    _exec_url = [NSURL URLWithString:strurl];
    
    [Logger log:self method:@"run" format: @"\n\t %@", strurl];
    
    if ( _exec_url == nil )
        return;
    
    _exec_request = [NSMutableURLRequest requestWithURL:_exec_url];
    [_exec_request setHTTPMethod:@"GET"];
    [_exec_request setHTTPShouldHandleCookies:NO];
    [_exec_request addValue:[NSString stringWithFormat:@"JSESSIONID=%@", _accessToken] forHTTPHeaderField:@"Cookie"];
    
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
    if ( isSuccessfull )
    {
        _resultCode = 0;
        
        _imageData = [[UIImage alloc] initWithData:_exec_data];
    }
    
    // Send signal to delegate
    // If delegate is not NIL, it conforms to correct protocol
    if ( _delegate )
        [_delegate getImageComplete:_resultCode image:_imageData imgId:_imageId reqId:_requestId];
}

@end
