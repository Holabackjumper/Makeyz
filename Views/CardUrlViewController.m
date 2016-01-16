//
//  CardUrlViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "CardUrlViewController.h"

@interface CardUrlViewController ()

@end

@implementation CardUrlViewController

@synthesize urlwebbString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//Background custom
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    
//TabBar custom
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setHidden:NO];
    
    NSString *combined = [NSString stringWithFormat:@"%@%@", @"http://", self.urlwebbString];
    NSURL *myURL = [NSURL URLWithString:combined];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
    [moiWebView loadRequest:myRequest];
    
}


@end
