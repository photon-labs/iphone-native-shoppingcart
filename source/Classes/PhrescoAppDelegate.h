//
//  iShopAppDelegate.h
//
//  Created by PHOTON on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class RootViewController;

@interface iShopAppDelegate : NSObject <UIApplicationDelegate, UITextViewDelegate> {
   
	UIWindow *window;

    NSDate *date;
	
    UIAlertView *alertView;
    
    RootViewController *viewController;
		
	Reachability *reachability;	
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSDate *date;	
@property (nonatomic, retain) UIAlertView *alertView;
@property (nonatomic, retain) Reachability *reachability;
@property (nonatomic, retain) IBOutlet RootViewController *viewController;


@end

