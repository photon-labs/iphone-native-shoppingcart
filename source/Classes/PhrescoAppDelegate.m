//
//  iShopAppDelegate.m
//  iShop
//
//  Created by PHOTON on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhrescoAppDelegate.h"
#import "RootViewController.h"
#import "Constants.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "UIUtils.h"
#import "DebugOutput.h"

@implementation iShopAppDelegate

@synthesize window;
@synthesize viewController;

@synthesize alertView;
@synthesize date;
@synthesize reachability;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	////////// Support ///////////
	NSDate *launchStart = [NSDate date];
	
	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
	
	appInfoEntity.appLaunchTime = launchStart;
	//////////////////////////////
		
    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	//[self syncAppPreferencesInDevice];
	///////// Support /////////////
	
	NSDate *pushToBackgroundStart = [NSDate date];
	
	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
	
	appInfoEntity.appPushbackTime = pushToBackgroundStart;
	
	//////////////////////////////
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	
	// when app enters foreground, call service for config File and check for updates
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)alertView:(UIAlertView *)alertView1 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //to avoid multiple alert
	if(buttonIndex == 0)
	{
		//Scenario::make alertview nil here ...so repeated messages will not display
		alertView = nil;
	}
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	[textView resignFirstResponder];
	return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
	[textView resignFirstResponder];
	return YES;
}

- (void)dealloc {
	
    [viewController release];
    [window release];
    [super dealloc];
}


@end
