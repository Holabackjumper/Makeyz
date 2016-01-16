//
//  ProfileTextTableViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"


#define SWITCH_KEY2 @"SwitchLamp.Key"
#define SWITCH_KEY3 @"SwitchLego.Key"
#define SWITCH_KEY5 @"ActiveProfile.Key"
#define SWITCH_KEY6 @"ActiveContact.Key"


@interface ProfileTextTableViewController : UITableViewController <UITextViewDelegate>
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *setupProfileTextView;

//Pick Category (Vore det inte kul om man kunde scanna sina visitkort istället)
@property (weak, nonatomic) IBOutlet UISwitch *switchTech;
@property (weak, nonatomic) IBOutlet UISwitch *switchDesign;
@property (weak, nonatomic) IBOutlet UISwitch *switchMarket;
@property (weak, nonatomic) IBOutlet UISwitch *switchFinance;
@property (weak, nonatomic) IBOutlet UISwitch *switchOther;

@property (weak, nonatomic) IBOutlet UILabel *techLabel;
@property (weak, nonatomic) IBOutlet UILabel *designLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *financeLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;


//Save Profile
- (IBAction)save:(id)sender;

-(void)save;


@end