//
//  LegoDetailsViewController.m
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-09-08.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import "LegoDetailsViewController.h"

@interface LegoDetailsViewController ()

@end

@implementation LegoDetailsViewController


//Display User
@synthesize lego;
@synthesize nameLabel;

- (void)viewDidLoad


{
    [super viewDidLoad];
    
    [self retriveFromParse];
    [self getUserFromParse];
    
    self.nameLabel.text = lego.name;
}

-(void)viewDidAppear:(BOOL)animated {
    [self getUserFromParse];
}

#pragma mark - Keyboard dismiss
- (BOOL)textFieldShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

//Get user from Parse
-(void)getUserFromParse {
    
    PFQuery *query= [PFUser query];
    [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                self.name = [object valueForKey:@"name"];
                self.emailOutlet.text = [object valueForKey:@"contactEmail"];
                self.webbOutlet.text = [object valueForKey:@"contactUrl"];
                self.phoneOutlet.text = [object valueForKey:@"contactPhone"];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)retriveFromParse
{
    PFUser *usertwo = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:lego.selectedUsername];
    [query whereKey:@"senderId" equalTo:usertwo.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                self.sentObject = object;
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


//Send your contact info to: 
- (IBAction)sendButton:(id)sender {
    
    NSString *alertmessage = [NSString stringWithFormat:@"%@ %@%@", @"Send contact information to:", lego.name, @"?"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:alertmessage delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
    {

    }
    else
    {
        
        [self.sentObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
            }
        }];
        
        PFUser *user = [PFUser currentUser];
        PFObject *send =  [PFObject objectWithClassName:lego.selectedUsername];
        [send setObject:user.username forKey:@"senderUsername"];
        [send setObject:user.objectId forKey:@"senderId"];
        [send setObject:self.name forKey:@"name"];
        [send setObject:[NSNumber numberWithBool:YES] forKey:@"New"];
        [send setObject:[NSNumber numberWithBool:NO] forKey:@"Welcome"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Sending";
        [hud show:YES];
        
        [send saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [hud hide:YES];
            
            if (!error) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully sent contact card" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

                NSString *pushMessage = [NSString stringWithFormat:@"%@ %@", @"New card from:", self.name];
                NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                      pushMessage, @"alert",
                                      @"Increment", @"badge",
                                      nil];
                
                PFPush *push = [[PFPush alloc] init];
                [push setChannel:lego.selectedUsername];
                [push setData:data];
                [push sendPushInBackground];
                
                [self retriveFromParse];

                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }];
    }
}


@end
