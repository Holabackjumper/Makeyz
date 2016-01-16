//
//  EmailViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface EmailViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

//Change color border
@property (strong, nonatomic) IBOutlet UILabel *frameLabel;

//Send Email
@property (strong, nonatomic) IBOutlet UITextField *mailField;

- (IBAction)saveUp:(id)sender;

@end
