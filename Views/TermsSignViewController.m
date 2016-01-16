//
//  TermsSignViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "TermsSignViewController.h"

@interface TermsSignViewController ()

@end

@implementation TermsSignViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//Makemove Terms of Use
    NSURL *myURL = [NSURL URLWithString:@"http://www.makemoves.se/terms"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
    [myWebView loadRequest:myRequest];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}


- (IBAction)close:(id)sender {
    
    UIButton *buttonThatWasPressed = (UIButton *)sender;
    buttonThatWasPressed.enabled = NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end