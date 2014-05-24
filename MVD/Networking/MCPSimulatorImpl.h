//
//  MCPSimulatorImpl.h
//  MobileBanking
//
//  Created by Sergey Sasin on 15.04.13.
//  Copyright (c) 2013 BPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProtocol.h"


@interface MCPSimulatorImpl : NSObject
    <MCProtocol>

@property (nonatomic, copy, readwrite) NSString *accessToken;
@property (nonatomic, assign, readwrite) int lastResult;

- (void) enableNetworkActivityIndicator:(BOOL)enable;



@end
