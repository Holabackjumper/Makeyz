//
//  ContactsViewController.h
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-11-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ContactCell.h"
#import "ContactDetailsController.h"

@interface ContactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contactTableView;

@property (strong, nonatomic) NSArray *contactsArray;
@property (weak, nonatomic) IBOutlet UIView *startContacView;


@end
