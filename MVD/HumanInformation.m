//
//  HumanInformation.m
//  MVD
//
//  Created by Denis Kurochkin on 12.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import "HumanInformation.h"

@implementation HumanInformation

- (id) init
{
    self = [super init];
    if (self)
    {
        _firstName = nil;
        _lastName = nil;
        _givenName = nil;
        _rank = -1;
        _post = -1;
        _birthDate = nil;
        _photos = nil;
        _biography = nil;
    }
    
    return  self;
}


@end
