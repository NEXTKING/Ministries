//
//  MinistryViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 27.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinistryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (nonatomic, copy) NSString *region;

- (IBAction)buttonAction:(UIButton *)sender;

@end
