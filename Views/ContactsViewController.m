//
//  ContactsViewController.m
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-11-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

@synthesize contactTableView;
@synthesize contactsArray;
@synthesize startContacView;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
//Navigation bar custom
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];



    contactTableView.delegate = self;
    contactTableView.dataSource = self;

    
    contactTableView.hidden = YES;
    startContacView.hidden = YES;
    
    [self loadContactData];
    
}

-(void)viewWillAppear:(BOOL)animated{

//Shows login if no user is logged in
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {

            [self loadContactData];
            
            NSNumber *activity = [[PFUser currentUser] objectForKey: @"inbox"];
            NSInteger value = [activity integerValue];
            value++;
            NSNumber *newActivity = [NSNumber numberWithInt:value];
            [[PFUser currentUser] setObject:newActivity forKey:@"inbox"];
            NSLog(@"inbox Activity: %@", newActivity);
            
        }
        else {
            [self dismissViewControllerAnimated:NO completion:nil];
            [self performSegueWithIdentifier:@"showLogin" sender:self];
            
        }

}

-(void)viewWillDisappear:(BOOL)animated{
    
      [[self navigationController] tabBarItem].badgeValue = nil;
    
}

-(void)loadContactData{
    
//Avoids query error if no currentuser
    PFUser *user = [PFUser currentUser];

//Gets list of Cards for CurrentUser from background
    PFQuery *contacts = [PFQuery queryWithClassName:user.username];
    [contacts orderByDescending:@"createdAt"];
    [contacts findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            contactsArray = [[NSArray alloc]initWithArray:objects];
            NSLog(@"my array is: %@", contactsArray);
            
            if (contactsArray.count == 0) {
                contactTableView.hidden = YES;
                startContacView.hidden = NO;
          
            }
            else{
                contactTableView.hidden = NO;
                startContacView.hidden = YES;
                [contactTableView reloadData];
            }
     
        }
    }];
   
    
}

- (void)didReceiveMemoryWarning {
  
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [contactsArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"contactsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
// Set the data for this cell:
    PFObject *tempObject = [contactsArray objectAtIndex:indexPath.row];
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [tempObject objectForKey:@"name"];
    
    if ([[[contactsArray objectAtIndex:indexPath.row] objectForKey:@"New"] boolValue ])
    {
        UIButton *new = (UIButton *) [cell viewWithTag:102];
        new.hidden = NO;
    }
    else
    {
        UIButton  *new = ( UIButton *) [cell viewWithTag:102];
        new.hidden = YES;
    }
    
    return cell;
}

#pragma mark prepare for seague

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showContactDetails"]) {
        NSIndexPath *indexPath = [self.contactTableView indexPathForSelectedRow];
        ContactDetailsController *destViewController = segue.destinationViewController;
        
        PFObject *object = [contactsArray objectAtIndex:indexPath.row];
        ContactCell *contact = [[ContactCell alloc] init];
        contact.name = [object objectForKey:@"name"];
        contact.sender = [object objectForKey:@"senderUsername"];
        destViewController.contact = contact;
        
    }

}


@end
