//
//  EditTableController.m
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-09-01.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//
#import "EditTableController.h"

@interface EditTableController ()

@end

@implementation EditTableController

//Profile
@synthesize profileImage;
@synthesize nameTextfield;
@synthesize titleTextfield;
@synthesize locationTextfield;

//ProfileText
@synthesize profileText;
//Contact
@synthesize urlTextfield;
@synthesize emailTextfield;
@synthesize phoneTextfield;

//Category
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
    

    
    [self getuserFromParse];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
//Navigation bar custom
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor orangeColor]}];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
//Background custom
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.png"]];
    
    
    CALayer *imager = profileImage.layer;
    [imager  setCornerRadius:50];
    [imager  setMasksToBounds:YES];
    
    [imager setBorderColor:[[UIColor whiteColor]CGColor]];
    [imager setBorderWidth:5];
    
    
    nameTextfield.delegate = self;
    titleTextfield.delegate = self;
    locationTextfield.delegate = self;
    profileText.delegate = self;
    urlTextfield.delegate = self;
    emailTextfield.delegate = self;
    phoneTextfield.delegate = self;
    
    nameTextfield.keyboardAppearance = UIKeyboardAppearanceAlert;
    titleTextfield.keyboardAppearance = UIKeyboardAppearanceAlert;
    locationTextfield.keyboardAppearance = UIKeyboardAppearanceAlert;
    profileText.keyboardAppearance = UIKeyboardAppearanceAlert;
   
    urlTextfield.keyboardAppearance = UIKeyboardAppearanceAlert;
    emailTextfield.keyboardAppearance = UIKeyboardAppearanceAlert;
    phoneTextfield.keyboardAppearance = UIKeyboardAppearanceAlert;

    //Placeholder custom
    if ([self.nameTextfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.nameTextfield .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    if ([self.titleTextfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.titleTextfield .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Headline" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    
    
    if ([self. locationTextfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self. locationTextfield .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    //Placeholder custom
    if ([self.urlTextfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.urlTextfield .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"URL" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        
    }
    
    
    
    if ([self.emailTextfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.emailTextfield .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        
    }
    
    
    
    if ([self.phoneTextfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.phoneTextfield  .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{

}

-(void)getuserFromParse{
    
    PFQuery *query= [PFUser query];
    
    [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        
        nameTextfield.text = [object valueForKey:@"name"];
        titleTextfield.text = [object valueForKey:@"title"];
        locationTextfield.text = [object valueForKey:@"location"];
        
        
        phoneTextfield.text = [object valueForKey:@"contactPhone"];
        urlTextfield.text = [object valueForKey:@"contactUrl"];
        emailTextfield.text = [object valueForKey:@"contactEmail"];
        
        NSNumber *techBOOL = [[PFUser currentUser] objectForKey: @"tech"];
        switchTech.on = [techBOOL boolValue];
        NSNumber *designBOOL = [[PFUser currentUser] objectForKey: @"design"];
        switchDesign.on = [designBOOL boolValue];
        NSNumber *marketBOOL = [[PFUser currentUser] objectForKey: @"market"];
        switchMarket.on = [marketBOOL boolValue];
        NSNumber *financeBOOL = [[PFUser currentUser] objectForKey: @"finance"];
        switchFinance.on = [financeBOOL boolValue];
        
        if (switchTech.on) {
            [self.techLabel setTextColor:[UIColor orangeColor]];
        }
        if (switchDesign.on) {
              [self.designLabel setTextColor:[UIColor orangeColor]];
        }
        if (switchMarket.on) {
            [self.marketLabel setTextColor:[UIColor orangeColor]];
        }
        if (switchFinance.on) {
            [self.financeLabel setTextColor:[UIColor orangeColor]];
        }
        
        NSMutableString *profileTextView2 = [NSMutableString string];
        for (NSString* line in [object objectForKey:@"ProfileText"]) {
            [profileTextView2 appendFormat:@"%@\n", line];
            
        }
        profileText.text = profileTextView2;
    }];
    
    PFFile *userImageFile = [PFUser currentUser][@"profileimageFile"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            self.profileImage.image = image;
        }
        
    }];
    
}

- (void)showPhotoLibary
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return;
    }
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
// Displays saved pictures from the Camera Roll album.
    mediaUI.mediaTypes = @[(NSString*)kUTTypeImage];
    
// Hides the controls for moving & scaling pictures
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = self;
    
    
    [self presentViewController:mediaUI animated:YES completion:nil];
}


- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    UIImage *originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage]; //it returns the edited image,
    self.profileImage.image = originalImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return profileText.text.length + (text.length - range.length) <= 202;
}

- (void) hideKeyboard {
    [nameTextfield resignFirstResponder];
    [titleTextfield resignFirstResponder];
    [locationTextfield resignFirstResponder];
    [profileText resignFirstResponder];
    [urlTextfield resignFirstResponder];
    [emailTextfield resignFirstResponder];
    [phoneTextfield resignFirstResponder];
}

- (IBAction)pickImage:(id)sender {
    [self showPhotoLibary];
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

// The user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[self navigationController] popViewControllerAnimated:YES];
        //  NSLog(@"Cancel");
    }
    else
    {
        [self save];
    }
}

- (IBAction)save:(id)sender {
    
    [self switchCheck];
    
}

-(void)save{
    
    if ([self.nameTextfield.text  isEqualToString:@""]) {
        //  NSLog(@"name IS empty!");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile" message:@"You have to have a name to create a profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        
        NSString *email = [self.emailTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *url = [self.urlTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *phone = [self.phoneTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([email length] == 0 && [url length] == 0 && [phone length] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Contact Card"
                                                                message:@"Please fill atleast one field in your contact information"
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        else {
            
            // Create PFObject with card information
            PFUser *profile = [PFUser currentUser];
            
            NSArray *moneyProfile = [profileText.text componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
            [profile setObject:moneyProfile forKey:@"ProfileText"];
            
// Profile image
            NSData *imageData = UIImageJPEGRepresentation(profileImage.image, 0.8);
            NSString *filename = [NSString stringWithFormat:@"%@", profile.username];
            PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
            [profile setObject:imageFile forKey:@"profileimageFile"];
            [profile setObject:phoneTextfield.text forKey:@"contactPhone"];
            [profile setObject:urlTextfield.text forKey:@"contactUrl"];
            [profile setObject:emailTextfield.text forKey:@"contactEmail"];
            [profile setObject:nameTextfield.text forKey:@"name"];
            [profile setObject:titleTextfield.text forKey:@"title"];
            [profile setObject:locationTextfield.text forKey:@"location"];
            [profile setObject:[NSNumber numberWithBool:YES] forKey:@"Active"];
            [profile setObject:[NSNumber numberWithBool:YES] forKey:@"ActiveContact"];
            [profile setObject:[NSNumber numberWithBool:switchTech.on] forKey:@"tech"];
            [profile setObject:[NSNumber numberWithBool:switchDesign.on] forKey:@"design"];
            [profile setObject:[NSNumber numberWithBool:switchMarket.on] forKey:@"market"];
            [profile setObject:[NSNumber numberWithBool:switchFinance.on] forKey:@"finance"];
            [profile setObject:[NSNumber numberWithBool:switchMarket.on] forKey:@"other"];
            [[PFUser currentUser] saveInBackground];
            
// Show progress
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"Updating";
            [hud show:YES];
            
// Upload profile to Parse
            [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
               
                [hud hide:YES];
                
                if (!error) {
                    // Show success message
                    [hud hide:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully updated profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else {
                    [hud hide:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Upload fail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }];
            
        }

    }
}
@end
