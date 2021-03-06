//
//  Logger.m
//  MobileBanking
//
//  Created by Denis Kurochkin on 25.03.14.
//  Copyright (c) 2014 BPC. All rights reserved.
//
#ifdef DEBUG
#import <objc/runtime.h>
#endif

#import "Logger.h"

@implementation Logger

+ (void) log:(id) k method:(NSString*) m format:(NSString*) f, ...;
{
#ifdef DEBUG
    va_list argumentList;
    va_start(argumentList, f);
    
    NSMutableString * prefix = [[NSMutableString alloc] init];
    if ( k != Nil )
        [prefix appendFormat:@"%s:", class_getName([k class])];
    if ( m != Nil && [m length] > 0 )
        [prefix appendFormat:@":%@: ", m];
    else
        [prefix appendString:@" "];
        
    NSMutableString * message = [[NSMutableString alloc] initWithString:f];
     
    if ( prefix && [prefix length] )
        [message insertString:prefix atIndex:0];
    
    NSLogv(message, argumentList); // Originally NSLog is a wrapper around NSLogv.
    
    va_end(argumentList);
    
    //[message release];
    //[prefix release];
#endif
}

@end
