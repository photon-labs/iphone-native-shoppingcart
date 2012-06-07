//
//  Webview.m
//
//  Created by PHOTON on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Webview.h"
#import "DebugOutput.h"
#import "UIUtils.h"
#import "PhrescoAppDelegate.h"
#import "RootViewController.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "Constants.h"

@implementation Webview
@synthesize requestURL;

//initialize the web view
-(id)initWithFrame:(CGRect)rect {
	
	self = [super initWithFrame:rect];
	
	if(self)
	{
        //set webview delegate
        self.delegate =  self;
	}
	
	return self;
}

-(void)reloadWebView {
	
	[self reload];	
}

-(void)stopLoading {
	
	[self stopLoading];	
}

-(BOOL)goPrevious {
	
	if(self.canGoBack)
	{
		[self goBack];
		return YES;
	}
    
	return NO;	
}

-(BOOL)goNext {
	
	if(self.canGoForward)
	{
		[self goForward];
		return YES;
	}
	
	return  NO;	
}

- (void)reLoadRequest:(NSURLRequest*)request {
    [self loadRequest:request];
}


#pragma mark webView delegate methods 

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	self.requestURL = request;

    //get this array from global list
    NSMutableArray *signOnList = [NSMutableArray array]; //WithObjects:@"/paybill/index.ognc",@"/myAccount.ognc", @"/myinfo/", nil];;
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
    
    NSString *signinUrlPatternMatch = [[assetsData.appInfo objectForKey:kappConfig] objectForKey:@"signinUrlPatternMatch"];
    
    if (nil != signinUrlPatternMatch) {
    
        [signOnList addObject:signinUrlPatternMatch];
    }    
    
    BOOL isSignIn = [self interceptURL:signOnList :[[request URL] absoluteString]];
    
    debug(@"requestURL: %@", self.requestURL);    
    
	//if its a link clicked.....
	if(navigationType == UIWebViewNavigationTypeLinkClicked)
	{
		//if user clicked on a link...		
	}
	else if(navigationType == UIWebViewNavigationTypeBackForward)
	{
		//if webview asked to go back...
	}
	else if(navigationType == UIWebViewNavigationTypeReload)
	{
		//if web view is reloaded.....		
	}
	else if(navigationType == UIWebViewNavigationTypeOther)
	{
		//any other type...ajax?		
	}	
	
	return YES;
}

- (void)webView:(UIWebView *)twebView didFailLoadWithError:(NSError *)error
{
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void) showLoading {
	
	if(self.loading)
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	else
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

/////////////////////////////////////////////////////////////////////////////////////////
//interceptURL
//
//Description:  Verifies if a given URL is in a specified URL list - for instance, check for forcedsignonList ,
//				AjaxurlList, .. etc. 
//
// IN:  (NSArray) URLInterceptList   :  a specified list of URLs to check
//		(NSString*) urlString       :  the specified URL to intercept 
//
// Out: If the url is found in the specified list 
//
//////////////////////////////////////////////////////////////////////////////////////////


-(BOOL)interceptURL:(NSArray*)URLInterceptList : (NSString*)urlString
{
	
	BOOL found = NO;
	
	if(nil != URLInterceptList)
	{
		for(int i = 0; i<[URLInterceptList count]; i++)
		{
			NSString *url = [URLInterceptList objectAtIndex:i];
			
			NSRange match = [urlString rangeOfString:url];
			
			if(match.location == NSNotFound)
			{
				found = NO;
				
			}
			
			else {
				
				found = YES;
				
				break;
				
			}
			
		}
	}
	
	return found;
	
}

@end


