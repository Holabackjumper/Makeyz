//
//  ProfileViewTableViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "ProfileViewTableViewController.h"

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController

//Active View
@synthesize profileImageView;
@synthesize nameTextField;
@synthesize titleTextField;
@synthesize locationTextField;
@synthesize profileTextView;

@synthesize intro1;
@synthesize profileButtonText;


int karma = 0;


- (void)viewDidLoad
{

    
    [super viewDidLoad];
    NSLog(@"1");

    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.png"]];
 
        // [self karmaPointCheck];
    
//Navigation bar custom
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setHidden:NO];
    
//TabBar custom
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    CALayer *imager = profileImageView.layer;
    [imager  setCornerRadius:50];
    [imager  setMasksToBounds:YES];
    
    [imager setBorderColor:[[UIColor whiteColor]CGColor]];
    [imager setBorderWidth:5];
  
}

-(void)getuserFromParse{
    
    PFQuery *query= [PFUser query];
    
    [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        if (!error) {
        //    NSLog(@"%@", object);
            
            nameTextField.text = [object valueForKey:@"name"];
            titleTextField.text = [object valueForKey:@"title"];
            locationTextField.text = [object valueForKey:@"location"];
            
            NSMutableString *profileTextView2 = [NSMutableString string];
            for (NSString* line in [object objectForKey:@"ProfileText"]) {
                [profileTextView2 appendFormat:@"%@\n", line];
            }
            profileTextView.text = profileTextView2;
            
            if (!error) {
            }
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFFile *userImageFile = [PFUser currentUser][@"profileimageFile"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            self.profileImageView.image = image;
        }
        else {
            // Log details of the failure
          //  NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"will innan");
       [super viewWillAppear:animated];
      NSLog(@"will innan");

    //Shows login if no user is logged in
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {

            [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        [self getuserFromParse];
       
        if ([self.nameTextField.text  isEqualToString:@""]) {
            
            self.intro1.hidden = NO;
            
        } else {
            
            self.intro1.hidden = YES;
            
        }
       
        NSNumber *activity = [[PFUser currentUser] objectForKey: @"profile"];
        NSInteger val = [activity integerValue];
        val++;
        NSNumber *newActivity = [NSNumber numberWithInt:val];
        [[PFUser currentUser] setObject:newActivity forKey:@"profile"];
        NSLog(@"profile Activity: %@", newActivity);
        
        PFQuery *query = [PFQuery queryWithClassName:[[PFUser currentUser]username]];
        [query whereKey:@"New" equalTo:[NSNumber numberWithBool:TRUE]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            self.newcards = [NSString stringWithFormat:@"%lu", (unsigned long)objects.count];
            
            
            if ([self.newcards  isEqualToString:@"0"]) {
                
                [[self navigationController] tabBarItem].badgeValue = nil;
            }
            else {

                [[[[[self tabBarController] tabBar] items]
                  objectAtIndex:2] setBadgeValue:[NSString stringWithFormat:@"%lu", (unsigned long)objects.count]];
                
            }
        }
         ];
        
    }
        
    else {
        [self performSegueWithIdentifier:@"goToLogin" sender:self];

    }
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            [[PFUser currentUser] setObject:geoPoint forKey:@"currentLocation"];
            [[PFUser currentUser] saveInBackground];
            //    NSLog(@"Current user: %@", geoPoint);
        }
    }];
    
 

}


-(void)karmaPointCheck{
    
    NSNumber *codeBOOL = [[PFUser currentUser] objectForKey: @"inviteCodeBOOL"];
    NSNumber *karmaPoints = [[PFUser currentUser] objectForKey: @"karmaPoints"];
    NSString *inviteCodeString = [[PFUser currentUser]objectForKey:@"inviteCodeString"];
    NSInteger value = [karmaPoints integerValue];
    bool hasNoInviteCode = [codeBOOL boolValue];
    NSLog(hasNoInviteCode ? @"Yes" : @"No");
    
    if (hasNoInviteCode){
        
        //Get karma
        PFUser *user = [PFUser currentUser];
        NSString *inviteCode = [user objectForKey:@"inviteCodeString"];
        NSNumber *numberPoint = [user objectForKey:@"karmaPoints"];
        karma = [numberPoint intValue];
        PFQuery *getPoints = [PFQuery queryWithClassName:@"AAAKarmaP"];
        [getPoints whereKey:@"userInviteCode" equalTo:inviteCode];
        [getPoints findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                unsigned long int y = 20;
                NSUInteger x = objects.count;
                unsigned long int karmaPoint = x * y;
                NSUInteger totalPoint = karma + karmaPoint;
                
                NSLog(@"karmaP: %lu", karmaPoint);
                NSArray *deadObjects = [objects valueForKey:@"objectId"];
                NSLog(@"deadobjects: %@", deadObjects);
                if (deadObjects.count > 0) {
                    for (NSString *object in deadObjects) {
                        
                        PFQuery *query = [PFQuery queryWithClassName:@"AAAKarmaP"];
                        [query getObjectInBackgroundWithId:object block:^(PFObject *karmaTotal, NSError *error) {
                            [karmaTotal deleteInBackground];
                        }];
                    }
                    [PFUser currentUser][@"karmaPoints"] = [NSNumber numberWithInt:totalPoint];
                    [[PFUser currentUser] saveInBackground];
                }
            }
            else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    
    else{
        NSString *alphabet  = @"ABCDEFGHIJKLMNOPQRSTUVWXZY";
        NSMutableString *code = [NSMutableString stringWithCapacity:20];
        for (NSUInteger i = 0U; i < 4; i++) {
            u_int32_t r = arc4random() % [alphabet length];
            unichar c = [alphabet characterAtIndex:r];
            [code appendFormat:@"%C", c];
            inviteCodeString = code;
            
        }
        if (value < 100){
            int y = 100;
            value = value + y;
        }
        else{
        }
        
            NSNumber *newKarma = [NSNumber numberWithInt:value];
        
            NSLog(@"Random code is %@", code);
            PFUser *user = [PFUser currentUser];
            [user setObject:inviteCodeString forKey:@"inviteCodeString"];
            [user setObject:[NSNumber numberWithBool:YES] forKey:@"inviteCodeBOOL"];
            [user setObject:newKarma forKey:@"karmaPoints"];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Saved: %@", user);
                //Sending Karma
                PFObject *karmaField =  [PFObject objectWithClassName:@"AAAKarmaP"];
                [karmaField setObject:inviteCodeString forKey:@"userInviteCode"];
                [karmaField setObject:user.username forKey:@"userName"];
                [karmaField setObject:[NSNumber numberWithInt:20] forKey:@"addedKarmaPoint"];
                [karmaField saveInBackground];
            }
            else {
                
            }
        }];
    }
}


- (IBAction)edit:(id)sender {
    [self performSegueWithIdentifier:@"setupProfile" sender:self];
}

- (IBAction)editProfileButton:(id)sender {
    [self performSegueWithIdentifier:@"setupProfile" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}



@end
