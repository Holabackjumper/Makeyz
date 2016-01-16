//
//  ContactDetailsController.h
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-11-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ContactCell.h"
#import <Parse/Parse.h>
#import "CardUrlViewController.h"
#import "CardProfileTableViewController.h"

@interface ContactDetailsController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) ContactCell *contact;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *urlButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

//Strings
@property (nonatomic, strong) NSString *emailsend;
@property (nonatomic, strong) NSString *phonecall;
@property (nonatomic, strong) NSString *urlwebb;

//Actions
- (IBAction)goToProfile:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)makeCall:(id)sender;
- (IBAction)goToUrl:(id)sender;

@end
