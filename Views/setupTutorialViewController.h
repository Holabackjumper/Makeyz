//
//  setupTutorialViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface setupTutorialViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *frameLabel;
@property (strong, nonatomic) IBOutlet UILabel *framelabel2;
@property (weak, nonatomic)IBOutlet UIImageView *backgroundImageView;


// Intro Movie
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

- (IBAction)playMovie:(id)sender;


@end



