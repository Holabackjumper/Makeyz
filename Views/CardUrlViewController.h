//
//  CardUrlViewController.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import <UIKit/UIKit.h>

@interface CardUrlViewController : UIViewController

{
    IBOutlet UIWebView	*moiWebView;
}

@property (nonatomic, strong) NSString *urlwebbString;
@property (nonatomic, strong) NSString *url;


@end
