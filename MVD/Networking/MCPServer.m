//
//  MCPServer.m
//  MobileBanking
//
//  Created by Denis Kurochkin on 25.03.14.
//  Copyright (c) 2014 BPC. All rights reserved.
//

#import "MCPServer.h"
#import "MCPNetworkImpl.h"

static id<MCProtocol> __inst = Nil;

@implementation MCPServer

// Singleton implementation
+ (id<MCProtocol>) instance
{
    if ( __inst == nil )
    {
        __inst = [[MCPNetworkImpl alloc] init]; // communication with real web-server
        //__inst = [[MCPSimulatorImpl alloc] init]; // simulation for test purposes
    }
    
    return __inst;
}

+ (void) destroy
{
    if ( __inst != Nil )
    {
       // [__inst release];
        __inst = Nil;
    }
}

@end
