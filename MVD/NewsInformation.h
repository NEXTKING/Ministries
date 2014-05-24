//
//  NewsInformation.h
//  MVD
//
//  Created by Denis Kurochkin on 23.05.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsInformation : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* photo;

@end
