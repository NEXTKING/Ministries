//
//  AnalyticsViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 31.01.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CounterComponentView.h"

@interface AnalyticsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//TEMPORARY!!!
@property (weak, nonatomic) IBOutlet CounterComponentView *component0;
@property (weak, nonatomic) IBOutlet CounterComponentView *component1;
@property (weak, nonatomic) IBOutlet CounterComponentView *component2;
@property (weak, nonatomic) IBOutlet CounterComponentView *component3;
@property (weak, nonatomic) IBOutlet CounterComponentView *component4;

@property (weak, nonatomic) IBOutlet CounterComponentView *component5;

//Active buttons



- (IBAction)repeatAnimation:(id)sender;
- (IBAction)buttonHandler:(UIButton*)sender;

@end
