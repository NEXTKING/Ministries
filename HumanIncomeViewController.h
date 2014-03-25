//
//  HumanIncomeViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 26.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumanIncomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


- (IBAction)leftSwipeSelector:(UISwipeGestureRecognizer*) sender;

- (IBAction)rightSwipeSelector:(UISwipeGestureRecognizer*) sender;

@property (weak, nonatomic) IBOutlet UIView *incomeWifeLeft;
@property (weak, nonatomic) IBOutlet UIView *incomeManLeft;
@property (weak, nonatomic) IBOutlet UIView *incomeWifeRight;
@property (weak, nonatomic) IBOutlet UIView *incomeManRighr;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabelLeft;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabelRight;

@property (weak, nonatomic) IBOutlet UIView *propertyWifeRight;
@property (weak, nonatomic) IBOutlet UIView *propertyManLeft;
@property (weak, nonatomic) IBOutlet UIView *propertyManRight;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabelLeft;

@property (weak, nonatomic) IBOutlet UILabel *propertyLabelRight;




@property (weak, nonatomic) IBOutlet UILabel *nextLabel;
@property (weak, nonatomic) IBOutlet UILabel *prevLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftYearLabel;


@end
