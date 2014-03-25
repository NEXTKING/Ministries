//
//  EmployeesViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 07.03.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum EmployeeType
{
    ETypeCommon = 0,
    ETypeHired,
    ETypeFired,
    ETypePromoted,
    ETypeAwarded
} EmployeeType;

@interface EmployeesViewController : UITableViewController

@property (nonatomic, assign) EmployeeType type;

@end
