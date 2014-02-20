//
//  AnalyticsViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 31.01.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalyticsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
