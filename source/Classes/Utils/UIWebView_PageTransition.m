//
//  UIWebView_Interceptor.m
//
//  Created by Admin on 25/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIWebView_PageTransition.h"
#import <QuartzCore/QuartzCore.h>

#define kWebViewScreenShotTag 22
#define kWebViewLoadingTag 23

@implementation  UIWebView(UIWebView_PageTransition)

//@dynamic loadingSnapShot,navigationDirection;
@dynamic loadingSnapShot,navigationDirection;


//Scenario 1 ---> user clicks a link in page for forward navigation:
//
//1. initNavigateForwardToPage (Call in UIVewBiew::shouldStartLoadWithRequest)
//
//2. animatePage    (Call in UIWebView::webViewDidFinishLoad)


//Scenario 2 ---> user clicks on previous Button:
//
//1. initNavigateBackToPage (Call in onButtonClick())
//
//2. animatePage    (Call in UIWebView::webViewDidFinishLoad)


-(void) initNavigateForwardToPage:(UIWebView*)webView 
					 // :(UIViewController *)parentViewController
{
	//navigationDirection = NEXT;
	
	UIView *loadingSnapShot=[[webView superview] viewWithTag:kWebViewScreenShotTag];
	
	if(loadingSnapShot==nil)
	{
		loadingSnapShot = [self createLoadingSnapShot:webView];
		
				
		[loadingSnapShot setTag:kWebViewScreenShotTag];
		
		//make sure our landing snapshot is in same pos as web view..
		loadingSnapShot.frame = webView.frame;
		
		[[webView superview] addSubview:loadingSnapShot];
	}
	
	
	//Scenario:: this function is called even when the user presses "Previous"
	//as  in some cases the URL redirects and that comes as a  loadrequest
	//so in that case, see if the web view is positioned for a previous load...if so
	//dont re-position
	if(webView.frame.origin.x==0)
		webView.frame = CGRectMake(320.0,
							   webView.frame.origin.y,
							   webView.frame.size.width,
							   webView.frame.size.height);
	
}

-(void) initNavigateBackToPage:(UIWebView*)webView {
	
	if(webView.canGoBack)
	{
		UIView * loadingSnapShot = [self createLoadingSnapShot:webView];
		
		loadingSnapShot.frame = webView.frame;
		
		webView.frame = CGRectMake(-320.0,
								   webView.frame.origin.y,
								   webView.frame.size.width,
								   webView.frame.size.height);
		
		[loadingSnapShot setTag:kWebViewScreenShotTag];
		
		[[webView superview] addSubview:loadingSnapShot];
		
		[webView goBack];
		
	}
}		

-(UIView*)createLoadingSnapShot:(UIWebView*)webView
{
	UIView *loadingView1, *loadingSnapShot1;
	
	//take Snapshot of WebView.....
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	// Create a new render context of the UIView size, and set a scale so that the full stage will render to it
	UIGraphicsBeginImageContext( CGSizeMake( webView.bounds.size.width, webView.bounds.size.height ) );
	CGContextScaleCTM( UIGraphicsGetCurrentContext(), 1.0f, 1.0f );
	
	// Render the stage to the new context
	[webView.layer renderInContext:UIGraphicsGetCurrentContext()];
	
	// Get an image from the context
	UIImage* viewImage = 0;
	viewImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// Kill the render context
	UIGraphicsEndImageContext();
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:viewImage];
	
	//[self.view addSubview:imageView];
	
	
	
	loadingSnapShot1 = [[UIView alloc]init];
	[loadingSnapShot1 addSubview:imageView];
	
	loadingView1 = [[UIView alloc]init];
	loadingView1.backgroundColor = [UIColor darkGrayColor];
	//loadingView1.frame = CGRectMake(0.0, 0.0, 320.0, 460.0);
	loadingView1.frame = CGRectMake(0.0, 
									[[UIScreen mainScreen] bounds].size.height, 
									320.0, 
	
									460.0);
	
	loadingView1.tag = kWebViewLoadingTag;
	loadingView1.hidden = NO;
	
	loadingView1.alpha = 0.9;

	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]init];
	spinner.frame = CGRectMake(150,174,20,20);

	[loadingView1 insertSubview:spinner aboveSubview:loadingView1];

	[spinner startAnimating];
	[spinner release];
	
	//Insert test logo - 104x28
	UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testImage"]];
	
	logo.frame = CGRectMake(100,145,104,28);
	
	[loadingView1 insertSubview:logo aboveSubview:spinner];
		
	[loadingSnapShot1 insertSubview:loadingView1 aboveSubview:imageView];

	return loadingSnapShot1;
}

//remove loading indicator...
-(void)pageTransitionComplete:(UIWebView*)webView

{
	UIView *loadingSnapShot= [[webView superview] viewWithTag:kWebViewScreenShotTag];
	
	if(loadingSnapShot!=nil)
	{
		[loadingSnapShot removeFromSuperview];
		[loadingSnapShot release];
		loadingSnapShot = nil;		
	}
}
-(void) animatePage:(UIWebView*)webView
{
	
	if(webView.frame.origin.x>=320.0 || webView.frame.origin.x<0)
	{
		   
		//now we assume here that the positions of the web view and loading view are set properly so we can animate back n forth..
		UIView *loadingSnapShot= [[webView superview] viewWithTag:kWebViewScreenShotTag];
	
		int direction=0;

		//check where web view was placed....if in left of screen(-320), animate right
		//and vice versa
		if(webView.frame.origin.x<0)
			direction=PREV; //1
		else
			direction=NEXT;//-1;
		
		[UIView beginAnimations:nil  context:nil];
		
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(pageTransitionComplete)];	
		[UIView setAnimationDuration:0.4];
		
		
		loadingSnapShot.frame = CGRectMake(loadingSnapShot.frame.origin.x + (320.0 * direction ),
										   loadingSnapShot.frame.origin.y,
										   loadingSnapShot.frame.size.width,
										   loadingSnapShot.frame.size.height);
		
		webView.frame = CGRectMake(webView.frame.origin.x + (320.0 * direction),
								   webView.frame.origin.y,
								   webView.frame.size.width,
								   webView.frame.size.height);
		
		NSLog(@"Now web view at:%f , %f...direction:%d",webView.frame.origin.x ,webView.frame.origin.y,direction); 
		
		[[webView superview] bringSubviewToFront:webView];
		[UIView commitAnimations];
		
		[self performSelector:@selector(pageTransitionComplete:) 
				   withObject:webView afterDelay:0.5];
		
	}
}

-(void) animateLoadingView:(UIWebView*)webView
{
	UIView 	*loadingView1= [[[webView superview] viewWithTag:kWebViewScreenShotTag] viewWithTag:kWebViewLoadingTag];

	[UIView beginAnimations:nil context:nil];
	
	[UIView setAnimationDuration:0.5];
	loadingView1.frame = CGRectMake(0.0, 
									0.0, 
									320.0, 
									460.0);
	loadingView1.hidden = NO;
	
	[UIView commitAnimations];

	[[webView superview] bringSubviewToFront:[[webView superview] viewWithTag:kWebViewScreenShotTag]];

}

@end
