//
//  LogInViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "LogInViewController.h"


@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    
//Log In with username + password
    _usernameField.delegate = self;
    _passwordField.delegate = self;
    
//Custom keyboard
    _usernameField.keyboardAppearance = UIKeyboardAppearanceAlert;
    _passwordField.keyboardAppearance = UIKeyboardAppearanceAlert;
    
//Placeholder custom
    if ([self.usernameField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.usernameField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    if ([self.passwordField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.passwordField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:animated];
}


- (IBAction)login:(id)sender {
    

    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud show:YES];
    [hud hide:YES];
   
    NSString *lowerusername = [self.usernameField.text lowercaseString];
    NSString *nospaceUsername = [lowerusername stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *username = [nospaceUsername stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ([username length] == 0 ) {
      
        UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@""
                                                             message:@"Username is to short"
                                                            delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       
        if  ([password length] == 0 ) {
    
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Password is to short"
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            [alertView show];
            [alertView2 show];
        }
        
    }
    else {
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                   message:@"Username and password don't match"
                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [hud hide:YES];
            }
            else {
                
                 [hud hide:YES];
                 [self dismissViewControllerAnimated:NO completion:nil];
                 [self.navigationController popToRootViewControllerAnimated:NO];
                
            }
        }];
    }
}

- (IBAction)forget:(id)sender
{
    [self getEmail];
}

- (void)getEmail {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Retrieve Password" message:@"Enter the email for your account" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        UITextField *emailTextField = [alertView textFieldAtIndex:0];
        self.email = emailTextField.text;
        
        PFQuery *query = [PFUser query];
        [query whereKey:@"email" equalTo:self.email];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error) {
                // The find succeeded.
                if (objects.count > 0) {
                    //the query found a user that matched the email provided in the text field, send the email
                    [self sendEmail:self.email];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent" message:@"Check your email shortly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email does not exist" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];

                   
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
    }
    
}

- (void)sendEmail:(NSString *)email
{
    [PFUser requestPasswordResetForEmailInBackground:email];
}

#pragma mark - Keyboard dismiss
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end

