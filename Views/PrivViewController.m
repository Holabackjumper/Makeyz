//
//  PrivViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "PrivViewController.h"

@interface PrivViewController ()

@end

@implementation PrivViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//Navigation bar custom    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setHidden:NO];
    
    
    
//Go to Privacy    
    NSURL *myURL = [NSURL URLWithString:@"http://www.makemoves.se/privacy"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
    [moiWebView loadRequest:myRequest];
}



@end
