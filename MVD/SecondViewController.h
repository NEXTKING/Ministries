//
//  SecondViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 05.11.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPServer.h"

@interface SecondViewController : UIViewController
    <UITableViewDataSource,
    UITableViewDelegate,
    UISearchBarDelegate,
    UIScrollViewDelegate,
    UISearchDisplayDelegate,
    UIPickerViewDataSource,
    UIPickerViewDelegate,
    PersonsDelegate,
    RanksDelegate,
    PostsDelegate,
    ResourcesExchangeDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *ministryLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *pickeView;

@property (weak, nonatomic) IBOutlet UIImageView *mapImage;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UITextField *_textfield;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction) tapHandler:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *rightTap;
- (IBAction)scrllTapHandler:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *leftTap;
@property (weak, nonatomic) IBOutlet UIImageView *leftArrow;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;

@property (nonatomic, assign) BOOL tabBarPressed;

//Loading Screen
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;



@end
