//
//  CategoryView.h
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-10-08.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+ZKPulseView.h"


@interface CategoryView : UITableViewController <CLLocationManagerDelegate>


//Category
@property (weak, nonatomic) IBOutlet UIButton *categorysOutlet;
@property (weak, nonatomic) IBOutlet UIButton *allOutlet;
@property (weak, nonatomic) IBOutlet UIButton *techOutlet;
@property (weak, nonatomic) IBOutlet UIButton *designOutlet;
@property (weak, nonatomic) IBOutlet UIButton *marketOutlet;
@property (weak, nonatomic) IBOutlet UIButton *financeOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cancelOutlet;

@property (weak, nonatomic) IBOutlet UILabel *text1Label;

//Set Location
@property (nonatomic, strong)CLLocation *currentLocation;
@property (nonatomic, strong) PFGeoPoint *currentGeoPoint;

//Hotspot aka event mode
@property (weak, nonatomic) IBOutlet UILabel *hotSpotNumber;
@property (weak, nonatomic) IBOutlet UIButton *hotSpotButtonOutlet;

//Category
- (IBAction)techButton:(id)sender;
- (IBAction)designButton:(id)sender;
- (IBAction)marketButton:(id)sender;
- (IBAction)finaceButton:(id)sender;
- (IBAction)allButton:(id)sender;
- (IBAction)categoryButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
