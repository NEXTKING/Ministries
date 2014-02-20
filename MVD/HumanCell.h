//
//  HumanCell.h
//  MVD
//
//  Created by Denis Kurochkin on 12.12.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
