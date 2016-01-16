//
//  LegoViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "LegoViewController.h"


@interface LegoViewController ()



@end

@implementation LegoViewController {
    
        CLLocationManager *locationManager;
    
    }

@synthesize headersliderKM;
@synthesize headerLabel;


//Location
@synthesize geonumber;
@synthesize numbers;
@synthesize currentGeoPoint;
@synthesize currentLocation;


//Category
@synthesize category;

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad
{
    
      [super viewDidLoad];
    
    // Set up the array with your numbers.
    numbers = [[NSMutableArray alloc] init];
    [numbers addObject:[NSNumber numberWithInt:0]];
    [numbers addObject:[NSNumber numberWithInt:1]];
    [numbers addObject:[NSNumber numberWithInt:2]];
 
//    headersliderKM.continuous = YES; // Make the slider 'stick' as it is moved.
    [headersliderKM setMinimumValue:0];
    [headersliderKM setMaximumValue:2];
    
    // This makes the slider call the -valueChanged: method when the user interacts with it.
    [headersliderKM addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    //Hittar GeoLocation för telefonen
  
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
  
    if(IS_OS_8_OR_LATER) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    
    //Navigation bar custom
    self.navigationItem.hidesBackButton = NO;
   [self.navigationController.navigationBar setHidden:NO];
    
    //Background custom
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.png"]];
     
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTable:)
                                                 name:@"refreshTable"
                                               object:nil];
}

- (void)valueChanged:(UISlider*)sender
{
    NSUInteger index = (NSUInteger)(headersliderKM.value + 0.5); // Round the number.
    [headersliderKM setValue:index animated:YES];
    NSLog(@"index: %lu", (unsigned long)index);
    
    NSNumber *number = [numbers objectAtIndex:index]; // <-- This is the number you want.
    NSLog(@"number: %@", number);
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
}

- (void)refreshTable:(NSNotification *) notification
{
    // Reload the users
    [self loadObjects];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshTable" object:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Disable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Enable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

#pragma mark query for tableview

- (void)loadObjects
{
    if (!self.currentGeoPoint)
    {
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geo, NSError *error)
         {
             self.currentGeoPoint = geo;
             [super loadObjects];
         }];
    }
    else
    {
        [super loadObjects];
    }
}



- (PFQuery *)queryForTable
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.category = [defaults objectForKey:@"category"];
    NSLog(@"Category %@", self.category);
    
   if ([self.geonumber length] == 0) {
       self.geonumber = @"4";
    }
    else {
    }
    NSString *newString = self.geonumber;
    double z = [newString doubleValue];
        
    PFQuery *query= [PFUser query];
    
    [query whereKey:@"username" notEqualTo:[[PFUser currentUser]username]];
    [query whereKey:self.category equalTo: [NSNumber numberWithBool:TRUE]];
    [query whereKey:@"Active" equalTo: [NSNumber numberWithBool:TRUE]];
    [query whereKey:@"currentLocation" nearGeoPoint:self.currentGeoPoint withinKilometers:z];
    [query orderByDescending:@"updatedAt"];
    
    self.pullToRefreshEnabled = YES;
    
    self.paginationEnabled = YES;
    
    self.objectsPerPage = 200;

    return query;
}

#pragma mark TableviewCell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"LegoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UITextView *profileText = (UITextView*) [cell viewWithTag:104];
    NSMutableString *mutableStingText = [NSMutableString string];
    for (NSString* Text in [object objectForKey:@"ProfileText"]) {
        [mutableStingText appendFormat:@"%@\n", Text];
        profileText.text = mutableStingText;
        
    }
    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"profileimageFile"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    // Rounded image + border
    CALayer *imager = thumbnailImageView.layer;
    [imager  setCornerRadius:50];
    [imager  setMasksToBounds:YES];
    [imager setBorderColor:[[UIColor whiteColor]CGColor]];
    [imager setBorderWidth:5];
  
    
    // Label cell custom
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"name"];
    
    UILabel *titleLabel = (UILabel*) [cell viewWithTag:102];
    titleLabel.text = [object objectForKey:@"title"];
    
    UILabel *locationLabel = (UILabel*) [cell viewWithTag:103];
    locationLabel.text = [object objectForKey:@"location"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"showLegoDetails"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         LegoDetailsViewController *destViewController = segue.destinationViewController;

         PFObject *object = [self.objects objectAtIndex:indexPath.row];
         LegoCell *lego = [[LegoCell alloc] init];
         lego.name = [object objectForKey:@"name"];
         lego.selectedUsername = [object objectForKey:@"username"];
         destViewController.lego = lego;
     }
 }




- (IBAction)actionSlider:(id)sender {
    
    [headersliderKM addTarget:self
                       action:@selector(actionSlider:)
             forControlEvents:UIControlEventValueChanged];
    
    if (headersliderKM.value >= 1.5) {
        [headersliderKM setValue:2 animated:NO];
        headerLabel.text = @"GROW SOME WINGS";
        self.geonumber = @"300000000";
    }
    else {
        if (headersliderKM.value >= 0.5) {
            [headersliderKM setValue:1 animated:NO];
            headerLabel.text = @"GRAB A CAB";
            self.geonumber = @"40";
        }
        else {
            [headersliderKM setValue:0 animated:NO];
            headerLabel.text = @"WALKING DISTANCE";
            self.geonumber = @"4";
    }
    }
    
    if (headersliderKM.value == 0) {
         [self loadObjects];
    }
    if (headersliderKM.value == 1) {
        [self loadObjects];
    }
    if (headersliderKM.value == 2) {
        [self loadObjects];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NextPage";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; 
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"+";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:150.0];
 
    
     cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundblack@2x.png"]];
    
    
    
    return cell;
}





@end


