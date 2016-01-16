//
//  LegoViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "LegoDetailsViewController.h"
#import "LegoCell.h"




@interface LegoViewController : PFQueryTableViewController <UIGestureRecognizerDelegate, CLLocationManagerDelegate>

//Location
@property (nonatomic, strong)CLLocation *currentLocation;
@property (nonatomic, strong) PFGeoPoint *currentGeoPoint;
@property (nonatomic, strong) NSString *geonumber;
@property (nonatomic, retain) NSMutableArray *numbers;



//Category
@property (nonatomic, retain) NSString *category;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UISlider *headersliderKM;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;


//Send your contact information
@property (nonatomic, strong) PFObject *sentObject;
@property (nonatomic, strong) PFObject *name;
@property (nonatomic, strong) NSString *SendToUsername;
@property (nonatomic, strong) NSObject *SendToName;

- (IBAction)actionSlider:(id)sender;

@end
