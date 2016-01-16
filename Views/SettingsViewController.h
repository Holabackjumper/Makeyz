//
//  SettingsViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>

@interface SettingsViewController : UITableViewController  <UITabBarControllerDelegate, MFMailComposeViewControllerDelegate>

//Review App
- (IBAction)goToReviews:(id)sender;
//Sign Out from Makemove
- (IBAction)logOut:(id)sender;


@end