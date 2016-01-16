//
//  PrivSignViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "PrivSignViewController.h"

@interface PrivSignViewController ()

@end

@implementation PrivSignViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//Makemove Privacy
    NSURL *myURL = [NSURL URLWithString:@"http://www.makemoves.se/privacy"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
    [moiWebView loadRequest:myRequest];
}

- (IBAction)close:(id)sender {
    
    
    UIButton *buttonThatWasPressed = (UIButton *)sender;
    buttonThatWasPressed.enabled = NO;
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
