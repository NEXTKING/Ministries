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

@interface BiographyViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet BiographyUnitView *biographyView;
@property (weak, nonatomic) IBOutlet ClipView *clipView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
