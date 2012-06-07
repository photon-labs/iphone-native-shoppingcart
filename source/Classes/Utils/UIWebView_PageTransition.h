//
//  UIWebView_Interceptor.h
//
//  Created by Admin on 25/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NEXT -1
#define PREV 1

@interface UIWebView(UIWebView_PageTransition)

//- (BOOL) isURL;

-(UIView *)loadingSnapShot;

-(int) navigationDirection;

-(void) initNavigateForwardToPage:(UIWebView*)webView;

-(void) initNavigateBackToPage:(UIWebView*)webView;

-(UIView*)createLoadingSnapShot:(UIWebView*)webView;

-(void) animatePage: (UIWebView*)webView;

-(void)pageTransitionComplete:(UIWebView*)webView;

-(void) animateLoadingView:(UIWebView*)webView;

@property(nonatomic,assign)UIView *loadingSnapShot;

@property (nonatomic, readonly) int navigationDirection;

@end
