//
//  ContactDetailsController.m
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-11-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import "ContactDetailsController.h"

@interface ContactDetailsController ()

@end

@implementation ContactDetailsController

@synthesize contact;
@synthesize nameLabel;
@synthesize urlButton;
@synthesize emailButton;
@synthesize phoneButton;
@synthesize urlwebb;
@synthesize emailsend;
@synthesize phonecall;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

   

    self.nameLabel.text = contact.name;
    
    PFQuery *query= [PFUser query];
    
    [query whereKey:@"username" equalTo:contact.sender];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        self.nameLabel.text = [object valueForKey:@"name"];
        self.urlwebb =  [object valueForKey:@"contactUrl"];
        self.emailsend = [object valueForKey:@"contactEmail"];
        self.phonecall = [object valueForKey:@"contactPhone"];
        self.emailsend = [object valueForKey:@"contactEmail"];
        self.phonecall = [object valueForKey:@"contactPhone"];
        self.urlwebb =   [object valueForKey:@"contactUrl"];
        
        [urlButton setTitle:self.urlwebb forState:UIControlStateNormal];
        [emailButton setTitle:self.emailsend forState:UIControlStateNormal];
        [phoneButton setTitle:self.phonecall forState:UIControlStateNormal];
        

        PFQuery *find = [PFQuery queryWithClassName:[[PFUser currentUser]username]];
        [find whereKey:@"senderUsername" equalTo:contact.sender];
        find.cachePolicy = kPFCachePolicyCacheThenNetwork;
        [find findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                for (PFObject *object in objects) {
                    
                    [object setObject:[NSNumber numberWithBool:NO] forKey:@"New"];
                    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                
                        } else {
                            NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
                    }];
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];


        if ([self.urlwebb  isEqualToString:@""]) {
            //  NSLog(@"myString IS empty:URL!");
            self.urlButton.hidden = YES;
        } else {
            //  NSLog(@"myString IS NOT empty, it is: %@", _url.text);
            self.urlButton.hidden = NO;
        }
        if ([self.emailsend  isEqualToString:@""]) {
            //  NSLog(@"myString IS empty:Email!");
            self.emailButton.hidden = YES;
        } else {
            //   NSLog(@"myString IS NOT empty, it is: %@", _url.text);
            self.emailButton.hidden = NO;
        }
        if ([self.phonecall  isEqualToString:@""]) {
            //  NSLog(@"myString IS empty:Phone!");
            self.phoneButton.hidden = YES;
        } else {
            //  NSLog(@"myString IS NOT empty, it is: %@", _url.text);
            self.phoneButton.hidden = NO;
        }
        
    }];


    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)sendEmail:(id)sender
{
    
    // Email Subject
    NSString *emailTitle = @"";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:self.emailsend];
    
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


- (IBAction)makeCall:(id)sender
{
MFMessageComposeViewController *controller =
[[MFMessageComposeViewController alloc] init];

if([MFMessageComposeViewController canSendText])
{
    NSString *str = [NSString stringWithFormat:@""];
    ;
    controller.body = str;
    controller.recipients = [NSArray arrayWithObjects:
                             self.phonecall, nil];
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

- (IBAction)goToUrl:(id)sender
{
    [self performSegueWithIdentifier:@"urlView" sender:self];
}

- (IBAction)goToProfile:(id)sender
{
      [self performSegueWithIdentifier:@"showProfile" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"urlView"])
    {
        CardUrlViewController *destViewController = segue.destinationViewController;
        destViewController.urlwebbString = self.urlwebb;
    }
    else if ([segue.identifier isEqualToString:@"showProfile"])
    {
        CardProfileTableViewController *destViewController = segue.destinationViewController;
        destViewController.profileNameString = contact.sender;
    }
    
}


@end
