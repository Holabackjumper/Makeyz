//
//  AppDelegate.m
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-11.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions


{
    
       [NSThread sleepForTimeInterval:1.5];
    
    
    // Parse key and ID
    [Parse setApplicationId:@"qNd3CE7uElRicpOMFeNbOnAN5w4LNtvlXxKkhYcX"
                  clientKey:@"VoJPCA9Fh5UEJ9NxhGURFfJpaLIPL9cv8XpKYBxx"];
    
    // Parse Analytics Option
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    
    
      // Twitter Key and Secret
    [PFTwitterUtils initializeWithConsumerKey:@"Hc9nxYuAL2zTSH5eMJj5UOh6a"
                               consumerSecret:@"eK39CG2mNAZJtPDfBPwUlIxUm7v8dyut7bvFzA4mXX6KQfPwc5"];
    
    
    
     // TabBar Tint color
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        //save the installation
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        [currentInstallation addUniqueObject:currentUser.username forKey:@"channels"];
        [currentInstallation saveInBackground];
        // here we add a column to the installation table and store the current user’s ID
        // this way we can target specific users later
        
        // while we’re at it, this is a good place to reset our app’s badge count
        // you have to do this locally as well as on the parse server by updating
        // the PFInstallation object
        if (currentInstallation.badge != 0) {
            currentInstallation.badge = 0;
            [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    // Handle error here with an alert…
                }
                else {
                    // only update locally if the remote update succeeded so they always match
                    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                    NSLog(@"updated badge");
                }
            }];
        }
    } else {
            
        // Show the signup screen here....
    }
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [PFPush storeDeviceToken:deviceToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Faild to register for push, %@",error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}



@end
