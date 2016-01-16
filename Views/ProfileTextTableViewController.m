//
//  ProfileTextTableViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import "ProfileTextTableViewController.h"


@interface ProfileTextTableViewController ()

{
    UITextView *_textViewBeingEdited;
}

@end

@implementation ProfileTextTableViewController

@synthesize setupProfileTextView;

//Pick Category (Vore det inte kul om man kunde scanna sina visitkort istället)
@synthesize switchTech;
@synthesize switchDesign;
@synthesize switchMarket;
@synthesize switchFinance;
@synthesize switchOther;

@synthesize techLabel;
@synthesize designLabel;
@synthesize marketLabel;
@synthesize financeLabel;
@synthesize otherLabel;

-(IBAction)tech:(id)sender{
    
    if (switchTech.on) {
        [switchTech setOn:YES animated:YES];
        [switchDesign setOn:NO animated:YES];
        [switchMarket setOn:NO animated:YES];
        [switchFinance setOn:NO animated:YES];
        [switchOther setOn:NO animated:YES];
        [self.techLabel setTextColor:[UIColor orangeColor]];
        [self.designLabel setTextColor:[UIColor whiteColor]];
        [self.marketLabel setTextColor:[UIColor whiteColor]];
        [self.financeLabel setTextColor:[UIColor whiteColor]];
        [self.otherLabel setTextColor:[UIColor whiteColor]];
        
    }
    else {
        [self.techLabel setTextColor:[UIColor whiteColor]];
    }
    
}
-(IBAction)design:(id)sender{
    
    if (switchDesign.on) {
        [switchTech setOn:NO animated:YES];
        [switchDesign setOn:YES animated:YES];
        [switchMarket setOn:NO animated:YES];
        [switchFinance setOn:NO animated:YES];
        [switchOther setOn:NO animated:YES];
        [self.techLabel setTextColor:[UIColor whiteColor]];
        [self.designLabel setTextColor:[UIColor orangeColor]];
        [self.marketLabel setTextColor:[UIColor whiteColor]];
        [self.financeLabel setTextColor:[UIColor whiteColor]];
        [self.otherLabel setTextColor:[UIColor whiteColor]];
    }
    else {
        [self.designLabel setTextColor:[UIColor whiteColor]];
    }
    
}
-(IBAction)market:(id)sender{
    if (switchMarket.on) {
        [switchTech setOn:NO animated:YES];
        [switchDesign setOn:NO animated:YES];
        [switchMarket setOn:YES animated:YES];
        [switchFinance setOn:NO animated:YES];
        [switchOther setOn:NO animated:YES];
        [self.techLabel setTextColor:[UIColor whiteColor]];
        [self.designLabel setTextColor:[UIColor whiteColor]];
        [self.marketLabel setTextColor:[UIColor orangeColor]];
        [self.financeLabel setTextColor:[UIColor whiteColor]];
        [self.otherLabel setTextColor:[UIColor whiteColor]];
    }
    else{
        [self.marketLabel setTextColor:[UIColor whiteColor]];
    }
    
}
-(IBAction)finance:(id)sender{
    
    if (switchFinance.on) {
        [switchTech setOn:NO animated:YES];
        [switchDesign setOn:NO animated:YES];
        [switchMarket setOn:NO animated:YES];
        [switchFinance setOn:YES animated:YES];
        [switchOther setOn:NO animated:YES];
        [self.techLabel setTextColor:[UIColor whiteColor]];
        [self.designLabel setTextColor:[UIColor whiteColor]];
        [self.marketLabel setTextColor:[UIColor whiteColor]];
        [self.financeLabel setTextColor:[UIColor orangeColor]];
        [self.otherLabel setTextColor:[UIColor whiteColor]];
    }
    else{
        [self.financeLabel setTextColor:[UIColor whiteColor]];
    }
    
}

-(IBAction)other:(id)sender{
    
    if (switchOther.on) {
        [switchTech setOn:NO animated:YES];
        [switchDesign setOn:NO animated:YES];
        [switchMarket setOn:NO animated:YES];
        [switchFinance setOn:NO animated:YES];
        [switchOther setOn:YES animated:YES];
        [self.techLabel setTextColor:[UIColor whiteColor]];
        [self.designLabel setTextColor:[UIColor whiteColor]];
        [self.marketLabel setTextColor:[UIColor whiteColor]];
        [self.financeLabel setTextColor:[UIColor whiteColor]];
        [self.otherLabel setTextColor:[UIColor orangeColor]];
    }
    else{
        [self.otherLabel setTextColor:[UIColor whiteColor]];
    }
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];

    
//Backgroundcustom
self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.png"]];


      setupProfileTextView.delegate = self;
    
      [self.setupProfileTextView endEditing:YES];
    
//Custom keyboard
    setupProfileTextView.keyboardAppearance = UIKeyboardAppearanceAlert;
        
    self.navigationItem.hidesBackButton = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void) hideKeyboard {
    [setupProfileTextView resignFirstResponder];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [setupProfileTextView resignFirstResponder];
}

-(void)switchCheck {
    
    if (self.switchTech.on ||
        self.switchMarket.on ||
        self.switchDesign.on ||
        self.switchFinance.on||
        self.switchOther.on) {
        NSLog(@"någon är på");
        [self save];
    }
    else {
        NSLog(@"båda är av");
        
        NSString *alertmessage = [NSString stringWithFormat:@"%@", @"Do you want to save without selecting a category?"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Choose a category" message:alertmessage delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    
    if (buttonIndex == 0)
    {
        
        //  NSLog(@"Cancel");
    }
    else
    {
        [self save];
    }
}

-(void)save {
    
// Create PFObject with profile information
    PFUser *profile = [PFUser currentUser];
    NSArray *moneyProfile = [setupProfileTextView.text componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    [profile setObject:moneyProfile forKey:@"ProfileText"];
    [profile setObject:[NSNumber numberWithBool:YES] forKey:@"Active"];
    [profile setObject:[NSNumber numberWithBool:YES] forKey:@"ActiveContact"];
    [profile setObject:[NSNumber numberWithBool:switchTech.on] forKey:@"tech"];
    [profile setObject:[NSNumber numberWithBool:switchDesign.on] forKey:@"design"];
    [profile setObject:[NSNumber numberWithBool:switchMarket.on] forKey:@"market"];
    [profile setObject:[NSNumber numberWithBool:switchFinance.on] forKey:@"finance"];
    [profile setObject:[NSNumber numberWithBool:switchMarket.on] forKey:@"other"];
    
    
// Show progress
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Uploading";
    [hud show:YES];
    
// Upload profile to Parse
    [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [hud hide:YES];
        
        if (!error) {
            
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
}

- (IBAction)save:(id)sender {

          [self switchCheck];

}

- (void)viewDidUnload {
    
    [self setSetupProfileTextView:nil];
    [super viewDidUnload];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return setupProfileTextView.text.length + (text.length - range.length) <= 202;
}




#pragma mark - Textfield delegate

- (void)textFieldDidBeginEditing:(UITextView *)textView {
    _textViewBeingEdited = textView;
}

- (void)textFieldDidEndEditing:(UITextView *)textView {
    _textViewBeingEdited = textView;
}



- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];

}
@end
