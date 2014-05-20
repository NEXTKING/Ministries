//
//  BiographyViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 19.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClipView.h"
#import "BiographyUnitView.h"
#import "HumanInformation.h"

@interface BiographyViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet BiographyUnitView *biographyView;
@property (weak, nonatomic) IBOutlet ClipView *clipView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *noBiographyLabel;

@property (strong, nonatomic) HumanInformation* humanInfo;




@end



@interface BiographyYear : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, strong) NSArray *events;

@end
