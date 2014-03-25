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

- (void) hello:(id<HelloDelegate>) delegate;
- (void) login:(NSString*)name pwd:(NSString *)pwd deviceId:(NSString *)devId devCode:(NSString *)devCode delegate:(id<LoginDelegate>)delegate;

@end
