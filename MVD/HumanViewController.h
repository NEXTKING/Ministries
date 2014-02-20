//
//  HumanViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 12.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HumanViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *littleTableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *headlineView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;

- (IBAction) favourites: (id) sender;
- (IBAction) gestureHandler:(id)sender;

@end
