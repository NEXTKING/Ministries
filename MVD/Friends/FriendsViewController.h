//
//  FriendsViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 13.03.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Carousel.h"
#import "HumanInformation.h"

@interface FriendsViewController : UIViewController <CarouselDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (strong, nonatomic) HumanInformation* humanInfo;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
