//
//  HumanInformation.h
//  MVD
//
//  Created by Denis Kurochkin on 12.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HumanIncomeInformation.h"

@interface HumanInformation : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *givenName;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger post;
@property (nonatomic, copy) NSString *rankName;
@property (nonatomic, copy) NSString *postName;
@property (nonatomic, strong) NSDate *birthDate;

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSArray *biography;
@property (nonatomic, strong) HumanIncomeInformation *incomeInformation;
@property (nonatomic, strong) NSArray* news;

//temp

@property (nonatomic, strong) UIImage *image;

@end
