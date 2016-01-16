//
//  InviteViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "InviteViewController.h"

@interface InviteViewController ()

@end

@implementation InviteViewController

//Invite Code
@synthesize inviteCodeTextfield;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFUser *user = [PFUser currentUser];
    inviteCode = [user objectForKey:@"inviteCodeString"];
    NSLog(@"invite: %@", inviteCode);
    
    inviteCodeTextfield.text = inviteCode;
    
//Custom nav bar
     [self.navigationController.navigationBar setHidden:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [inviteCodeTextfield resignFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

//Share with email
- (IBAction)showEmail:(id)sender {
    UIButton *buttonThatWasPressed = (UIButton *)sender;
    buttonThatWasPressed.enabled = NO;
    
// Email Subject
    NSString *emailTitle = @"Check out - Makemove App";

// Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Meet talented people outside your network with Makemove! Invite code: %@ https://itunes.apple.com/app/id883667173", inviteCode];

// To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
// Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
    
}

//Share with SMS
-(IBAction)sendSMS:(id)sender {
    

MFMessageComposeViewController *controller =
[[MFMessageComposeViewController alloc] init];

if([MFMessageComposeViewController canSendText])
{
    NSString *str = [NSString stringWithFormat:@"Makemove invite code: %@ https://itunes.apple.com/app/id883667173", inviteCode];
     ;
    controller.body = str;
    controller.recipients = [NSArray arrayWithObjects:
                             @"", nil];
    controller.messageComposeDelegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}


}

- (void)messageComposeViewController:
(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Failed");
            break;
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
        [self dismissViewControllerAnimated:YES completion:nil];
}

//Share on Twitter
- (IBAction)postToTwitter:(id)sender {
    
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Makemove invite code: %@ https://itunes.apple.com/app/id883667173", inviteCode]];;
        
        
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}


//Share on Facebook
- (IBAction)postToFacebook:(id)sender {
    
    {
        
        SLComposeViewController *Facebooksheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [Facebooksheet setInitialText:[NSString stringWithFormat:@"Makemove - Meet talented people outside your network. Invite code: %@ https://itunes.apple.com/app/id883667173", inviteCode]];
        [Facebooksheet addImage:[UIImage imageNamed:@"start.png"]];
        [Facebooksheet addURL:[NSURL URLWithString:@"http://www.makemoves.se/"]];
         [Facebooksheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled :(");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Sucessfully Post :)");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:Facebooksheet animated:YES completion:nil];


    }
    
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