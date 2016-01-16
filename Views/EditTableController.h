//
//  EditTableController.h
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-09-01.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

#define SWITCH_KEY2 @"SwitchLamp.Key"
#define SWITCH_KEY3 @"SwitchLego.Key"

@interface EditTableController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>



//Profile
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *locationTextfield;

//Category
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



//ProfileText
@property (weak, nonatomic) IBOutlet UITextView *profileText;

//Contact
@property (weak, nonatomic) IBOutlet UITextField *urlTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextfield;

//IBActions
- (IBAction)pickImage:(id)sender;
- (IBAction)save:(id)sender;

//Void
-(void)save;

@end
