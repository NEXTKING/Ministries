//
//  MinistryStructureViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 13.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinistryStructureViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *localUnitsView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *localUnitsTextField;

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction) tapHandler:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;

@end
