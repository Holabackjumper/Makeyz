//
//  HotSpotCell.h
//  Makemoves
//
//  Created by Jonatan Lindahl on 2014-11-06.
//  Copyright (c) 2014 Uzibazooka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface HotSpotCell : NSObject

//Pick User
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *selectedUsername;

@end
