//
//  CardProfileTableViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface CardProfileTableViewController : UITableViewController <UIAlertViewDelegate>


@property (nonatomic, strong) NSString *profileNameString;
@property (strong, nonatomic) IBOutlet PFImageView *cardProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *cardProfileName;
@property (weak, nonatomic) IBOutlet UILabel *cardProfileTitle;
@property (weak, nonatomic) IBOutlet UILabel *cardProfileLocation;
@property (weak, nonatomic) IBOutlet UITextView *cardProfileTextView;
@property (nonatomic, strong) NSString *selectedUserName;
@property (nonatomic, strong) PFObject *sentObject;
@property (nonatomic, strong) PFObject *name;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (nonatomic, strong) NSString *returnNameString;

-(void)getuserFromParse;
-(void)retriveFromParse;
-(void)getSecondUserFromParse;

-(IBAction)sendCard:(id)sender;


@end
