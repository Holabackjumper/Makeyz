//
//  InviteMViewController.m
//  Makemoves
//
//  Created by Sam Englund on 2014-09-05.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import "InviteMViewController.h"

@interface InviteMViewController ()


@end

@implementation InviteMViewController

@synthesize inviteArray;
@synthesize invitecodeText;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Invite friend with custom code
    
    invitecodeText.delegate = self;
    invitecodeText.keyboardAppearance = UIKeyboardAppearanceAlert;
    
    PFQuery *query = [PFQuery queryWithClassName:@"AAAAINVITES"];
    [query getObjectInBackgroundWithId:@"GLv2D2kLWi" block:^(PFObject *objects, NSError *error) {

        self.inviteArray = [objects objectForKey:@"invites"];
         NSLog(@"Available codes %@", self.inviteArray);
    }];
    
    PFQuery *uquery= [PFUser query];
    
    [uquery whereKey:@"inviteCodeBOOL" equalTo: [NSNumber numberWithBool:TRUE]];
    [uquery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.userinviteArray = [objects valueForKey:@"inviteCodeString"];
        NSLog(@"Available codes %@", self.userinviteArray);
    }];
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [invitecodeText resignFirstResponder];
}



- (IBAction)joinNow:(id)sender {
    
    if (![self.inviteArray containsObject:self.invitecodeText.text]) {
        
        if (![self.userinviteArray containsObject:self.invitecodeText.text]) {
            
            
            UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@""
                                                                 message:@"Make sure you enter a correct invite code"
                                                                delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView2 show];
            
        } else {
            
            PFObject *karmaField =  [PFObject objectWithClassName:@"AAAKarmaP"];
            [karmaField setObject:self.invitecodeText.text forKey:@"userInviteCode"];
            [karmaField setObject:[NSNumber numberWithInt:20] forKey:@"addedKarmaPoint"];
            [karmaField saveInBackground];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [self performSegueWithIdentifier:@"lateryo" sender:self];
            
        }
        
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self performSegueWithIdentifier:@"lateryo" sender:self];
        
    }
}
    

- (IBAction)Count:(id)sender {
    
    
    // Email Subject
    NSString *emailTitle = @"Early access";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"earlyaccess@makemove.se"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - Keyboard dismiss
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
