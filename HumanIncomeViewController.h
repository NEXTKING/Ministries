//
//  HumanIncomeViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 26.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumanIncomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *background;


@end
