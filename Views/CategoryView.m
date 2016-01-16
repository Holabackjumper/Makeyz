//
//  CategoryView.m
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-10-08.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import "CategoryView.h"

@interface CategoryView ()

@property (weak, nonatomic) IBOutlet UIView *roundView;


@end


@implementation CategoryView {
    
    CLLocationManager *locationManager;
    
}

//Pick Category
@synthesize categorysOutlet;

//Category
@synthesize allOutlet;
@synthesize techOutlet;
@synthesize designOutlet;
@synthesize marketOutlet;
@synthesize financeOutlet;
@synthesize cancelOutlet;
@synthesize text1Label;

//Location
@synthesize currentLocation;


//Hotspot aka event mode
@synthesize hotSpotNumber;
@synthesize hotSpotButtonOutlet;



#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//Navigation bar custom
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    
    
//TabBar custom
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    



//Finf GeoLocation for the phone
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers; // 100 m
    
    
    if(IS_OS_8_OR_LATER) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
 
    
  
  
//Background custom
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.png"]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.cancelOutlet.hidden = YES;
    
//Hotspot aka event mode
    CALayer *hotButton = hotSpotButtonOutlet.layer;
    [hotButton setCornerRadius:50];
    [hotButton setMasksToBounds:YES];
    [hotButton setBorderColor:[[UIColor whiteColor]CGColor]];
    [hotButton setBorderWidth:5];
 
    self.roundView.layer.cornerRadius = 50;

    
//Category
    CALayer *filter = categorysOutlet.layer;
    [filter setCornerRadius:50];
    [filter  setMasksToBounds:YES];
    [filter setBorderColor:[[UIColor whiteColor]CGColor]];
    [filter setBorderWidth:5];
    
    
//Pick Category
    CALayer *all = allOutlet.layer;
    [all setCornerRadius:45];
    [all  setMasksToBounds:YES];
    [all setBackgroundColor:[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]CGColor]];
    [all setBorderColor:[[UIColor whiteColor]CGColor]];
    [all setBorderWidth:4.5];
    
    allOutlet.alpha = 0.0;
    
    CALayer *tech = techOutlet.layer;
    [tech  setCornerRadius:45];
    [tech  setMasksToBounds:YES];
    [tech setBorderColor:[[UIColor whiteColor]CGColor]];
    [tech setBackgroundColor:[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]CGColor]];
    [tech setBorderWidth:4.5];
    techOutlet.alpha = 0.0;
    
    CALayer *design = designOutlet.layer;
    [design  setCornerRadius:45];
    [design  setMasksToBounds:YES];
    [design setBorderColor:[[UIColor whiteColor]CGColor]];
    [design setBackgroundColor:[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]CGColor]];
    [design setBorderWidth:4.5];
    designOutlet.alpha = 0.0;
    
    CALayer *market = marketOutlet.layer;
    [market  setCornerRadius:45];
    [market  setMasksToBounds:YES];
    [market setBorderColor:[[UIColor whiteColor]CGColor]];
    [market setBackgroundColor:[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]CGColor]];
    [market setBorderWidth:4.5];
    marketOutlet.alpha = 0.0;
    
    CALayer *finance = financeOutlet.layer;
    [finance  setCornerRadius:45];
    [finance  setMasksToBounds:YES];
    [finance setBorderColor:[[UIColor whiteColor]CGColor]];
    [finance setBackgroundColor:[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4]CGColor]];
    [finance setBorderWidth:4.5];
    financeOutlet.alpha = 0.0;

 
}

-(void)viewWillAppear:(BOOL)animated{
    
    PFUser *user = [PFUser currentUser];
    NSNumber *activity = [user objectForKey: @"search"];
    NSInteger value = [activity integerValue];
    value++;
    NSNumber *newActivity = [NSNumber numberWithInt:value];
    [user setObject:newActivity forKey:@"search"];
    [user saveInBackground];
    NSLog(@"search Activity: %@", newActivity);
    
     [self getHotSpotUsers];
    
}



-(void)getHotSpotUsers{


    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geo, NSError *error)
     {
         self.currentGeoPoint = geo;
         PFQuery *query= [PFUser query];
         [query whereKey:@"username" notEqualTo:[[PFUser currentUser]username]];
         [query whereKey:@"Active" equalTo: [NSNumber numberWithBool:TRUE]];
         [query whereKey:@"ProfileText" notEqualTo:@""];
         [query whereKey:@"ProfileText" notEqualTo:@","];
         [query whereKey:@"currentLocation" nearGeoPoint:geo withinKilometers:1];
         [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
             NSLog(@"The objects are %@", objects);
             NSUInteger x = objects.count;
             unsigned long int y = x;
             self.hotSpotNumber.text = [NSString stringWithFormat:@"%lu", y];
             NSLog(@"The number are %lu", y);
             
             
             if (y < 7) {
                 [self.roundView stopPulseEffect];
                 NSLog(@"under");
             }
             else {
                 
                 [self.roundView startPulseWithColor:[UIColor redColor]];
                 NSLog(@"over");
             }
            
         }];
     }];
    

    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.currentLocation = newLocation;
    
    if (self.currentLocation != nil) {
        
     //   NSLog(@"Location: %.8f and %.8f", self.currentLocation.coordinate.longitude, self.currentLocation.coordinate.latitude);
        
        [self getHotSpotUsers];
        [locationManager stopUpdatingLocation];
        
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
            if (!error) {
                [[PFUser currentUser] setObject:geoPoint forKey:@"currentLocation"];
                [[PFUser currentUser] saveInBackground];
                //    NSLog(@"Current user: %@", geoPoint);
            }
        }];
    
    }

}
-(void)viewDidDisappear:(BOOL)animated{


}


//Pick Category

- (IBAction)techButton:(id)sender {
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"tech" forKey:@"category"];
    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"search" sender:self];
    
}

- (IBAction)designButton:(id)sender {
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"design" forKey:@"category"];
    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"search" sender:self];
    
}

- (IBAction)marketButton:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"market" forKey:@"category"];
    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"search" sender:self];
    
}

- (IBAction)finaceButton:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"finance" forKey:@"category"];
    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"search" sender:self];
    
}

- (IBAction)allButton:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"Active" forKey:@"category"];
    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"search" sender:self];
    
}

- (IBAction)categoryButton:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        techOutlet.alpha = 1.0,
        designOutlet.alpha = 1.0,
        marketOutlet.alpha = 1.0,
        financeOutlet.alpha = 1.0,
        allOutlet.alpha = 1.0;
        categorysOutlet.alpha = 0.0;
        text1Label.alpha = 0.2;
        hotSpotButtonOutlet.alpha = 0.2;
        
    }];
    self.cancelOutlet.hidden = NO;
    self.roundView.hidden = YES;
    self.hotSpotNumber.hidden = YES;

    
}

- (IBAction)cancelButton:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        techOutlet.alpha = 0.0,
        designOutlet.alpha = 0.0,
        marketOutlet.alpha = 0.0,
        financeOutlet.alpha = 0.0,
        allOutlet.alpha = 0.0;
        categorysOutlet.alpha = 1.0;
        text1Label.alpha = 1.0;
        hotSpotButtonOutlet.alpha = 1.0;
    }];
    self.cancelOutlet.hidden = YES;
    self.roundView.hidden = NO;
    self.hotSpotNumber.hidden = NO;
    
}


@end
