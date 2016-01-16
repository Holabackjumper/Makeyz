//
//  LegoCell.h
//  Makemoves
//
//  Created by Uzibazooka on 2014-04-14.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface LegoCell : NSObject

//Pick user
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *selectedUsername;

@end