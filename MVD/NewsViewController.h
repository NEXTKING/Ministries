//
//  NewsViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 26.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HumanInformation.h"

@interface NewsViewController : UITableViewController

@property (nonatomic, strong) HumanInformation *human;

@end
