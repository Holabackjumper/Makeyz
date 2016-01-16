//
//  TermsViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//Navigation bar custom
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setHidden:NO];
    
//Go to Terms of Use
    NSURL *myURL = [NSURL URLWithString:@"http://www.makemoves.se/terms"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
    [myWebView loadRequest:myRequest];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}


@end
