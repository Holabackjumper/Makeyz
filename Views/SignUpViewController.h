//
//  SignUpViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#define SWITCH_KEY2 @"SwitchLamp.Key"
#define SWITCH_KEY3 @"SwitchLego.Key"
#define SWITCH_KEY5 @"ActiveProfile.Key"
#define SWITCH_KEY6 @"ActiveContact.Key"


@interface SignUpViewController : UIViewController <UITextFieldDelegate>


//Sign Up with username + password + email
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;



- (IBAction)signup:(id)sender;


@end