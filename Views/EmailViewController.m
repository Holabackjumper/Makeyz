//
//  EmailViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self.navigationController.navigationBar setHidden:NO];
    PFUser *currentUser = [PFUser currentUser];
    _mailField.text = [currentUser valueForKey:@"email"];
    _mailField.delegate = self;
    _mailField.keyboardAppearance = UIKeyboardAppearanceAlert;
   
    
//Change color border
   _frameLabel.layer.borderWidth = 3.0f;
    _frameLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    
//Placeholder custom
    if ([self.mailField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.mailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Change Email" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 30) ? NO : YES;
}


//Send Email
- (IBAction)saveUp:(id)sender {
  
    PFUser *profile = [PFUser currentUser];
    [profile setObject:_mailField.text forKey:@"email"];
    [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

#pragma mark - Textfield delegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_mailField resignFirstResponder];

}

#pragma mark - Keyboard dismiss
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
