//
//  InviteMViewController.h
//  Makemoves
//
//  Created by Sam Englund on 2014-09-05.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>


@interface InviteMViewController : UIViewController <MFMailComposeViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *inviteArray;
@property (nonatomic, strong) NSMutableArray *userinviteArray;
@property (weak, nonatomic) IBOutlet UITextField *invitecodeText;

- (IBAction)joinNow:(id)sender;
- (IBAction)Count:(id)sender;

@end
