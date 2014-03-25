//
//  Logger.h
//  MobileBanking
//
//  Created by Denis Kurochkin on 25.03.14.
//  Copyright (c) 2014 BPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

+ (void) log:(id) k method:(NSString*) m format:(NSString*) f, ...;

@end
