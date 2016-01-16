//
//  setupTutorialViewController.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.

#import "setupTutorialViewController.h"


@interface setupTutorialViewController ()

@end

@implementation setupTutorialViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     {
        self.backgroundImageView.image = [UIImage imageNamed:@"VideoStart.png"];
    }

//Change color + width border
    _frameLabel.layer.borderWidth = 1.0f;
    _frameLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
    _framelabel2.layer.borderWidth = 1.0f;
    _framelabel2.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


// Intro Movie
-(void)playMovie:(id)sender
{

    UIButton *buttonThatWasPressed = (UIButton *)sender;
    buttonThatWasPressed.enabled = NO;
    
    NSString * str=[[NSBundle mainBundle]pathForResource:@"yo2" ofType:@"mov"];
    NSURL * url=[NSURL fileURLWithPath:str];
    MPMoviePlayerController * movieController=[[MPMoviePlayerController alloc]initWithContentURL:url];
    movieController.controlStyle=MPMovieControlStyleFullscreen;
    [movieController.view setFrame:self.view.bounds];
    [self.view addSubview:movieController.view];
    [movieController prepareToPlay];
    [movieController play];
    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
   _moviePlayer.fullscreen = YES;
   _moviePlayer.scalingMode = MPMovieScalingModeAspectFill;

    _moviePlayer.controlStyle = MPMovieControlStyleNone;
   
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];

   
}



- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    
    // Remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 [self performSegueWithIdentifier:@"show" sender:self];
                             }];
    
}

@end
