//
//  PassViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "PassViewController.h"

@interface PassViewController ()

@end

@implementation PassViewController

@synthesize sendButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//Custom backgorund
    self.backgroundImageView.image = [UIImage imageNamed:@"background@2x.png"];
  
//Custom nav bar
     [self.navigationController.navigationBar setHidden:NO];


//Change color border
    sendButton.layer.borderWidth = 3.0f;
    sendButton.layer.borderColor = [[UIColor whiteColor] CGColor];

}


//Get new password
- (IBAction)saveUp:(id)sender

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


@end
