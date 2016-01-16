//
//  StartViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.navigationItem.hidesBackButton = YES;
  
}

-(void)viewWillAppear:(BOOL)animated
{
       
      [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (IBAction)later:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
