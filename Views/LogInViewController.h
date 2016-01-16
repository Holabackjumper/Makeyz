//
//  LogInViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface LogInViewController : UIViewController <UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


//Log In with username + password
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@property (nonatomic, strong) NSString *email;


- (IBAction)login:(id)sender;

- (IBAction)forget:(id)sender;


@end
