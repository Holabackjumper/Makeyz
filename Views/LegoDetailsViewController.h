//
//  LegoDetailsViewController.h
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-09-08.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LegoCell.h"
#import "MBProgressHUD.h"

@interface LegoDetailsViewController : UIViewController <UITextViewDelegate>

//Display User
@property (nonatomic, strong) LegoCell *lego;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



//Send your contact information
@property (nonatomic, strong) PFObject *sentObject;
@property (nonatomic, strong) PFObject *name;
@property (weak, nonatomic) IBOutlet UILabel *emailOutlet;
@property (weak, nonatomic) IBOutlet UILabel *webbOutlet;
@property (weak, nonatomic) IBOutlet UILabel *phoneOutlet;


-(void)retriveFromParse;
-(void)getUserFromParse;


- (IBAction)sendButton:(id)sender;


@end
