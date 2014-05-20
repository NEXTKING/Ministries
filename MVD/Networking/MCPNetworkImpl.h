//
//  MCPNetworkImpl.h
//  MobileBanking
//
//  Created by Denis Kurochkin on 25.03.14.
//  Copyright (c) 2014 BPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProtocol.h"

@interface MCPNetworkImpl : NSObject
    <MCProtocol>

@property (nonatomic, copy, readwrite) NSString *accessToken;
@property (nonatomic, assign, readwrite) int lastResult;

- (void) persons:(id<PersonsDelegate>)delegate;


@end
