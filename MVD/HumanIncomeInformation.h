//
//  HumanIncomeInformation.h
//  MVD
//
//  Created by Denis Kurochkin on 20.05.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyInformation : NSObject

@property (nonatomic, assign) double personValue;
@property (nonatomic, assign) double wifeValue;
@property (nonatomic, assign) NSUInteger year;

@end

@interface HumanIncomeInformation : NSObject

@property (nonatomic, strong) NSArray *realEstate;
@property (nonatomic, strong) NSArray *money;
@property (nonatomic, strong) NSArray *stead;
@property (nonatomic, strong) NSArray *cars;

@end
