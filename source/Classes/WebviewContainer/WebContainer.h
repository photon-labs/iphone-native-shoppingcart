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
