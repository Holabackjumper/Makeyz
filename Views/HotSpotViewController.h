//
//  HotSpotViewController.h
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-11-06.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "HotSpotDetailsViewController.h"
#import "HotSpotCell.h"

@interface HotSpotViewController : PFQueryTableViewController <UIGestureRecognizerDelegate>



@property (nonatomic, strong) PFGeoPoint *currentGeoPoint;
@property (nonatomic, strong) NSString *geonumber;
@property (nonatomic, retain) NSMutableArray *numbers;

@property (nonatomic, strong) PFObject *sentObject;
@property (nonatomic, strong) PFObject *name;
@property (nonatomic, strong) NSString *SendToUsername;
@property (nonatomic, strong) NSObject *SendToName;

@end
