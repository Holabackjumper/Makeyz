//
//  ProfileSetupViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import "ProfileSetupViewController.h"

@interface ProfileSetupViewController  () {
   
    UITextField *_textFieldBeingEdited;
}

@end

@implementation ProfileSetupViewController

//Uploud profile picture
@synthesize profileImageView;

//Set up user profile(Vore det inte kul om man kunde scanna sina visitkort istället)
@synthesize nameTextField;
@synthesize titleTextField;
@synthesize locationTextField;
@synthesize phoneTextField;
@synthesize emailTextField;
@synthesize urlTextField;

- (void)viewDidLoad
{
    

    [super viewDidLoad];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];


//Profile image styling 
    {
        [self.profileImageView.layer setCornerRadius:50];
        [self.profileImageView.layer setMasksToBounds:YES];
        [self.profileImageView.layer setBorderColor:[[UIColor whiteColor]CGColor]];
        [self.profileImageView.layer setBorderWidth:5];
    }


//Backgroundcustom
 self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.png"]];
   
 self.navigationItem.hidesBackButton = NO;
    
    
//Set up user profile(Vore det inte kul om man kunde scanna sina visitkort istället)
    locationTextField.delegate = self;
    titleTextField.delegate = self;
    nameTextField.delegate = self;
    
    phoneTextField.delegate = self;
    emailTextField.delegate = self;
    urlTextField.delegate = self;
    
    
  
//Custom keyboard
    locationTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
    titleTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
    nameTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
    phoneTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
    emailTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
    urlTextField.keyboardAppearance = UIKeyboardAppearanceAlert;

//Uploud profile picture
    CALayer *image = profileImageView.layer;
    [image  setCornerRadius:50];
    [image  setMasksToBounds:YES];
    
    [image setBorderColor:[[UIColor whiteColor]CGColor]];
    [image setBorderWidth:5];
    

//Placeholder custom
    if ([self.titleTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.titleTextField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Headline" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    if ([self.emailTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.emailTextField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        
    }
    
    if ([self.nameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.nameTextField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
     
    }
    
    
    if ([self.locationTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.locationTextField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
     
    }
    
    
    if ([self.urlTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.urlTextField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"URL" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");

    }
    
    
    
    if ([self.phoneTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor grayColor];
        self.phoneTextField .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
     
 
    }
    

    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

//Hide Keyboard
- (void) hideKeyboard {
    [nameTextField resignFirstResponder];
    [titleTextField resignFirstResponder];
    [locationTextField resignFirstResponder];
    
    [phoneTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    [urlTextField resignFirstResponder];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextField resignFirstResponder];
    [titleTextField resignFirstResponder];
    [locationTextField resignFirstResponder];
    
    [phoneTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    [urlTextField resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self showPhotoLibary];
    }
    if (_textFieldBeingEdited) {
        [_textFieldBeingEdited resignFirstResponder];
    }
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
    self.profileImageView.image = originalImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    

}

- (IBAction)pickPhoto:(id)sender {
      [self showPhotoLibary];
}

// Save user profile
- (IBAction)save:(id)sender {

    if ([self.nameTextField.text  isEqualToString:@""]) {
        NSLog(@"name IS empty!");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile" message:@"You have to have a name to create a profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else {
        NSLog(@"name IS NOT empty, it is: %@", self.nameTextField.text);
        
        NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *url = [self.urlTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *phone = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([email length] == 0 && [url length] == 0 && [phone length] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Contact Card"
                                                                message:@"Please Fill Atleast One Field"
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        else {
            
        
// Create PFObject with information
    PFUser *profile = [PFUser currentUser];
    [profile setObject:nameTextField.text forKey:@"name"];
    [profile setObject:titleTextField.text forKey:@"title"];
    [profile setObject:locationTextField.text forKey:@"location"];
    [profile setObject:phoneTextField.text forKey:@"contactPhone"];
    [profile setObject:emailTextField.text forKey:@"contactEmail"];
    [profile setObject:urlTextField.text forKey:@"contactUrl"];
    

    NSData *imageData = UIImageJPEGRepresentation(profileImageView.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"%@", profile.username];
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////VI MÅSTE GÖRA NÅGOT HÄR DÅ DET BARA ÄR NAMETEXTFIELD SOM ÄR VIKTIG////////////
            //////////////////////////////////////////////////////////////////////////////
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [profile setObject:imageFile forKey:@"profileimageFile"];
    
  
    
// Show progress
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Uploading";
    [hud show:YES];
    
// Upload to Parse
    [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [hud hide:YES];

        if (!error) {
            
// Show success message
            
            [self performSegueWithIdentifier:@"setupProfileText" sender:self];
            
        }
        
    }];
    }
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)viewDidUnload {
    [self setProfileImageView:nil];
    [self setNameTextField:nil];
    [self setTitleTextField:nil];
    [self setLocationTextField:nil];
    [super viewDidUnload];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setupProfileText"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    
}



#pragma mark - Textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _textFieldBeingEdited = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    // no need to resignFirstResponder here.
    _textFieldBeingEdited = nil;
}

#pragma mark - Keyboard dismiss
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




@end
