//
//  NewsDescriptionViewController.h
//  MVD
//
//  Created by Denis Kurochkin on 22.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDescriptionViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadActivity;

@end
