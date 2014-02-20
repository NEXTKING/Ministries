//
//  main.m
//  MVD
//
//  Created by Denis Kurochkin on 05.11.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    
    NSArray *langOrder = [NSArray arrayWithObjects:@"ru", nil];
    [[NSUserDefaults standardUserDefaults] setObject:langOrder forKey:@"AppleLanguages"];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
