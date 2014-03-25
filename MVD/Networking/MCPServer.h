//
//  MCPServer.h
//  MobileBanking
//
//  Created by Denis Kurochkin on 25.03.14.
//  Copyright (c) 2014 BPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProtocol.h"

#define ACCESS_TOKEN_AUTO Nil

@interface MCPServer : NSObject
{
}

+ (id<MCProtocol>) instance;

@end
