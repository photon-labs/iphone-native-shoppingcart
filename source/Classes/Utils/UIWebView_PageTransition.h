/*
 * ###
 * PHR_IphoneNative
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
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
