//
//  CardProfileTableViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "CardProfileTableViewController.h"

@interface CardProfileTableViewController ()

@end

@implementation CardProfileTableViewController

@synthesize profileNameString;

@synthesize cardProfileImage;
@synthesize cardProfileName;
@synthesize cardProfileTitle;
@synthesize cardProfileLocation;
@synthesize cardProfileTextView;
@synthesize returnNameString;

@synthesize sentObject;
@synthesize name;
@synthesize selectedUserName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//Background custom
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.png"]];
        
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    
//TabBar custom
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    CALayer *imager = cardProfileImage.layer;
    [imager  setCornerRadius:50];
    [imager  setMasksToBounds:YES];
    
    [imager setBorderColor:[[UIColor whiteColor]CGColor]];
    [imager setBorderWidth:5];
    
    
//Change border
    cardProfileTextView.layer.borderWidth = .0f;
    cardProfileTextView.layer.borderColor = [[UIColor whiteColor] CGColor];
 
}

-(void)getuserFromParse
{
    PFQuery *query= [PFUser query];
    
    [query whereKey:@"username" equalTo:profileNameString];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        if (!error) {
            self.cardProfileName.text = [object valueForKey:@"name"];
            self.cardProfileTitle.text =  [object valueForKey:@"title"];
            self.cardProfileLocation.text = [object valueForKey:@"location"];
            
            self.returnNameString = [object valueForKey:@"name"];
            
            self.selectedUserName = [object valueForKey:@"username"];
            
            NSMutableString *profileTextView2 = [NSMutableString string];
            for (NSString* line in [object objectForKey:@"ProfileText"]) {
                [profileTextView2 appendFormat:@"%@\n", line];
            }
            cardProfileTextView.text = profileTextView2;
            
            NSString *profileTextTest = [profileTextView2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([profileTextTest  isEqualToString:@""]) {
                //  NSLog(@"myString IS empty:profile!");
                self.cardProfileTextView.hidden = YES;
            } else {
                //  NSLog(@"myString IS NOT empty, it is: %@", self.profileTextView.text);
                self.cardProfileTextView.hidden = NO;
            }
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *imagePic= [PFUser query];
    [imagePic whereKey:@"username" equalTo:profileNameString];
     imagePic.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [imagePic getFirstObjectInBackgroundWithBlock:^(PFObject *imageDown, NSError *error){
        if (!error) {
    PFFile *userImageFile = [imageDown objectForKey:@"profileimageFile"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            self.cardProfileImage.image = image;
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
        }
        else {
            
        }
         }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self getuserFromParse];
    [self retriveFromParse];
    [self getSecondUserFromParse];
}

-(void)retriveFromParse
{
    PFUser *usertwo = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:self.profileNameString];
    [query whereKey:@"senderId" equalTo:usertwo.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
        //    NSLog(@"Successfully retrieved %lu matching cards .", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                self.sentObject = object;
           //     NSLog(@"%@", self.sentObject);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)getSecondUserFromParse {
    
    PFQuery *query= [PFUser query];
    [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                self.name = [object valueForKey:@"name"];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(IBAction)sendCard:(id)sender {
  
    NSString *alertmessage = [NSString stringWithFormat:@"%@ %@%@", @"Send your contact information to:", self.returnNameString, @"?"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:alertmessage delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
  }


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

// The user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        
        NSLog(@"Cancel");
    }
    else
    {
        
    
    [self.sentObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
        }
    }];
    
    PFUser *user = [PFUser currentUser];
    PFObject *send =  [PFObject objectWithClassName:self.profileNameString];
   [send setObject:user.username forKey:@"senderUsername"];
    [send setObject:user.objectId forKey:@"senderId"];
    [send setObject:self.name forKey:@"name"];
    [send setObject:[NSNumber numberWithBool:YES] forKey:@"New"];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Sending";
    [hud show:YES];
    
    [send saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [hud hide:YES];
        
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully sent contact card" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
            

           NSString *pushMessage = [NSString stringWithFormat:@"%@ %@", @"New card from:", self.name];
            NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                  pushMessage, @"alert",
                                  @"Increment", @"badge",
                                  nil];

            PFPush *push = [[PFPush alloc] init];
            [push setChannel:self.selectedUserName];
            [push setData:data];
            [push sendPushInBackground];

            [self retriveFromParse];

        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];

        }
        
    }];
    
   }
   }


@end