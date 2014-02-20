//
//  FirstViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 05.11.13.
//  Copyright (c) 2013 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
