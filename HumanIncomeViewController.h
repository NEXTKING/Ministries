//
//  HumanIncomeViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 26.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HumanInformation.h"

@interface HumanIncomeViewController : UIViewController


- (IBAction)leftSwipeSelector:(UISwipeGestureRecognizer*) sender;

- (IBAction)rightSwipeSelector:(UISwipeGestureRecognizer*) sender;

//Money UI

@property (weak, nonatomic) IBOutlet UIView *moneyLeftMan;
@property (weak, nonatomic) IBOutlet UIView *moneyLeftWife;
@property (weak, nonatomic) IBOutlet UILabel *moneyLableLeft;


@property (weak, nonatomic) IBOutlet UIView *moneyMiddleMan;
@property (weak, nonatomic) IBOutlet UIView *moneyMiddleWife;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabelMiddle;


@property (weak, nonatomic) IBOutlet UIView *moneyRightMan;
@property (weak, nonatomic) IBOutlet UIView *moneyRightWife;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabelRight;

//Real Estate UI

@property (weak, nonatomic) IBOutlet UIView *estateLeftMan;
@property (weak, nonatomic) IBOutlet UIView *estateLeftWife;
@property (weak, nonatomic) IBOutlet UILabel *estateLabelLeft;

@property (weak, nonatomic) IBOutlet UIView *estateMiddleMan;
@property (weak, nonatomic) IBOutlet UIView *estateMiddleWife;
@property (weak, nonatomic) IBOutlet UILabel *estateLabelMiddle;

@property (weak, nonatomic) IBOutlet UIView *estateRightMan;
@property (weak, nonatomic) IBOutlet UIView *estateRightWife;
@property (weak, nonatomic) IBOutlet UILabel *estateLabelRight;


//Stead UI

@property (weak, nonatomic) IBOutlet UIView *steadLeftMan;
@property (weak, nonatomic) IBOutlet UIView *steadLeftWife;
@property (weak, nonatomic) IBOutlet UILabel *steadLabelLeft;

@property (weak, nonatomic) IBOutlet UIView *steadMiddleMan;
@property (weak, nonatomic) IBOutlet UIView *steadMiddleWife;
@property (weak, nonatomic) IBOutlet UILabel *steadLabelMiddle;

@property (weak, nonatomic) IBOutlet UIView *steadRightMan;
@property (weak, nonatomic) IBOutlet UIView *steadRightWife;
@property (weak, nonatomic) IBOutlet UILabel *steadLabelRight;





//UI Data

@property (strong, nonatomic) HumanInformation* humanInfo;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *rightYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftYearLabel;



@end
