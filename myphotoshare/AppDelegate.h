//
//  AppDelegate.h
//  
//
//  Created by Phan Nguyen on 3/26/2015.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseLoginViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, PFLogInViewControllerDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableData *profilePictureData;

- (void)presentLoginControllerAnimated:(BOOL)animated;
@end
