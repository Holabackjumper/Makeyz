//
//  SignUpViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import "SignupViewController.h"


@interface SignUpViewController ()


@end


@implementation SignUpViewController


- (void)viewDidLoad

{
    
    [super viewDidLoad];

//Sign Up with username + password + email
	_usernameField.delegate = self;
    _passwordField.delegate = self;
    _emailField.delegate = self;

    
//Custom keyboard
    _usernameField.keyboardAppearance = UIKeyboardAppearanceAlert;
    _passwordField.keyboardAppearance = UIKeyboardAppearanceAlert;
    _emailField.keyboardAppearance = UIKeyboardAppearanceAlert;
    
    
//Placeholder custom
    if ([self.usernameField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.usernameField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
      
    }
    
    if ([self.emailField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.emailField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
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
    [_emailField resignFirstResponder];
}


UIButton *disabledButton;

- (IBAction)signup:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud show:YES];
    
    NSString *lowerusername = [self.usernameField.text lowercaseString];
    NSString *nospaceUsername = [lowerusername stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *username = [nospaceUsername stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] invertedSet];
    
    NSLog(@"Mina uppgifter är: %@ %@ %@", self.passwordField.text, self.emailField.text, self.usernameField.text);
    
    
  //Se till så att man kan ha siffror i användarnament, det är bara om dom börjar med en siffra som det blir problem.
    
    if ([username length] == 0 || [username rangeOfCharacterFromSet:set].location != NSNotFound) {
     
        [hud hide:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                             message:@"Make sure you enter a username with out special characters and numbers"
                                                            delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
         [alertView show];
        
        
    if  ([password length] == 0 ) {
            
            [hud hide:YES];
            
            UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@""
                                                                 message:@"Make sure you enter a password"
                                                                delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
   
               [alertView2 show];
            
            
         if  ([email length] == 0 ) {
             
             [hud hide:YES];
             
             UIAlertView *alertView3 = [[UIAlertView alloc] initWithTitle:@""
            message:@"Make sure you enter a valid email"
                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     
            
        [alertView3 show];
       
            
            
         }
            
        }
        
    }
    else {
       
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        NSString *name = @"";
        [newUser setObject:name forKey:@"name"];
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
          
            if (error) {
                  [hud hide:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                
            }
            else {
                
                [self saveUserDefaults];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                [self performSegueWithIdentifier:@"setupProfile" sender:self];
                
                
              
            }
        
        }];

    }

}



- (void)saveUserDefaults {

    NSLog(@"saveUserDefaults");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
 
    [defaults setBool:NO forKey:SWITCH_KEY2];
    [defaults setBool:NO forKey:SWITCH_KEY3];
    [defaults setBool:NO forKey:SWITCH_KEY5];
    [defaults setBool:NO forKey:SWITCH_KEY6];

    
    
    [defaults synchronize];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setupProfile"]) {
    }
    
}

#pragma mark - Text length Username + Password + Email
- (BOOL)textField:(UITextField *)username shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [username.text length] + [string length] - range.length;
    return (newLength > 70) ? NO : YES;
}
#pragma mark


            
#pragma mark - Keyboard dismiss
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


            
         
           
@end

