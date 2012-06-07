//
//  Webview.h
//
//  Created by PHOTON on 01/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum WebviewNavigation {
	WebviewNavigateLeftToRight = 1,
	WebviewNavigateRightToLeft,
	WebviewNavigateTopToBottom,
	WebviewNavigateBottomToTop
}WebviewNavigationType;


@interface Webview : UIWebView<UIWebViewDelegate> {
	
	NSURLRequest *requestURL;
	
}

@property (nonatomic,retain)NSURLRequest *requestURL; 

-(BOOL)goPrevious;
-(BOOL)goNext;
-(BOOL)interceptURL:(NSArray*)URLInterceptList : (NSString*)urlString;
@end