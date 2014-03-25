//
//  NewsDescriptionViewController.m
//  MVD
//
//  Created by Denis Kurochkin on 22.02.14.
//  Copyright (c) 2014 Denis Kurochkin. All rights reserved.
//

#import "NewsDescriptionViewController.h"

@interface NewsDescriptionViewController ()

@end

@implementation NewsDescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_loadActivity startAnimating];
    NSString *address = @"news";
    NSString *path = [[NSBundle mainBundle] pathForResource:address ofType:@"html"];
    NSURL *url  = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
        // Do any additional setup after loading the view from its nib.
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [_loadActivity stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
