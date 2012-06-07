//
//  MWebContainer.h
//
//  Created by PHOTON on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Webview;
@class NavigationBar;

@interface WebContainer : UIViewController {

	Webview *iWebview;
    NavigationBar *iNavigationBar;
    
    BOOL willHideHeader;
}

@property (nonatomic, retain) Webview *iWebview;
@property (nonatomic, retain) NavigationBar *iNavigationBar;
@property (nonatomic, assign) BOOL willHideHeader;

-(void)loadWebViewWithRequest:(NSString*)requestToLoad;
-(void)addNavigationBar;

@end
