//
//  WebContainer.m
//
//  Created by PHOTON on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebContainer.h"
#import "NavigationBar.h"
#import "WebUtils.h"

#define kWebContainerFrame CGRectMake(0, 0, 320, 411)
#define kWebViewRect CGRectMake(0, 44, 320, 387)

@implementation WebContainer

@synthesize iWebview;
@synthesize iNavigationBar;
@synthesize willHideHeader;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        iWebview = [[Webview alloc] initWithFrame:kWebViewRect];
        self.view.frame = kWebContainerFrame;
        iWebview.delegate = iWebview;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:iWebview];   
}

- (void)addNavigationBar {

    if (nil != self.iNavigationBar) {
        [self.view addSubview:(UIView*)self.iNavigationBar];
    }
}

- (void)willHideHeader:(BOOL)hideHeader {
 
    if (hideHeader) {
       [iNavigationBar setHidden:YES];
    }
}

#pragma mark webView handler utilty methods
/*
-(void)loadWebViewWithRequest:(NSString*)requestToLoad {   
	
	NSURLRequest *requestURL = [NSURLRequest requestWithURL:[NSURL URLWithString:requestToLoad]];
	[iWebview loadRequest:requestURL];	
}
*/
-(void)loadWebViewWithRequest:(NSString*)requestToLoad {   
	
	NSMutableURLRequest *requestURL = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestToLoad]];
		
	[iWebview loadRequest:requestURL];	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [iWebview release];
    [iNavigationBar release];
    [super dealloc];
}


@end
