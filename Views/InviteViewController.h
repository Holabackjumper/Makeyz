//
//  InviteViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface InviteViewController : UIViewController < UITextFieldDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>{
    
    NSString *inviteCode;
}



@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

//Invite Code
@property (strong, nonatomic) IBOutlet UITextField *inviteCodeTextfield;


//Share app
- (IBAction)showEmail:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;
- (IBAction)sendSMS:(id)sender;

@end