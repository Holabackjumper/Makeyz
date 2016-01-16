//
//  HotSpotViewController.m
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-11-06.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import "HotSpotViewController.h"

@interface HotSpotViewController ()

@end

@implementation HotSpotViewController {
    
    CLLocationManager *locationManager;
    
}

@synthesize geonumber;
@synthesize numbers;
@synthesize currentGeoPoint;



#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
//Find GeoLocation for the phone
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
    
    PFQuery *query= [PFUser query];
    
    [query whereKey:@"username" notEqualTo:[[PFUser currentUser]username]];
    [query whereKey:@"Active" equalTo: [NSNumber numberWithBool:TRUE]];
    [query whereKey:@"ProfileText" notEqualTo:@""];
    [query whereKey:@"ProfileText" notEqualTo:@","];
    [query whereKey:@"currentLocation" nearGeoPoint:self.currentGeoPoint withinKilometers:1];
 
    self.pullToRefreshEnabled = YES;
    
    self.paginationEnabled = YES;
    
    self.objectsPerPage = 200;
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"HotSpotCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
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
    
    UITextView *profileText = (UITextView*) [cell viewWithTag:104];
    NSMutableString *mutableStingText = [NSMutableString string];
    for (NSString* Text in [object objectForKey:@"ProfileText"]) {
        [mutableStingText appendFormat:@"%@\n", Text];
        profileText.text = mutableStingText;
        
    }
    
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
    if ([segue.identifier isEqualToString:@"showHotSpotDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HotSpotDetailsViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        HotSpotCell *hotspot = [[HotSpotCell alloc] init];
        hotspot.name = [object objectForKey:@"name"];
        hotspot.selectedUsername = [object objectForKey:@"username"];
        destViewController.hotspot = hotspot;
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
