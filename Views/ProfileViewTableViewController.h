//
//  ProfileViewTableViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#define SWITCH_KEY2 @"SwitchLamp.Key"
#define SWITCH_KEY3 @"SwitchLego.Key"

@interface ProfileTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationTextField;
@property (weak, nonatomic) IBOutlet UITextView *profileTextView;

@property (nonatomic, strong) NSString *newcards;

- (IBAction)edit:(id)sender;

-(void)getuserFromParse;

@property (weak, nonatomic) IBOutlet UIView *intro1;


//Intro View
@property (weak, nonatomic) IBOutlet UITextView *profileButtonText;

- (IBAction)editProfileButton:(id)sender;

@end
