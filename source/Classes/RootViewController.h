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
//  iShopViewController.h
//  iShop
//
//  Created by PHOTON on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHandler.h"

@class WebContainer;
@class Tabbar;
@class NavigationBar;
@class SearchViewController;
@class HomeViewController;
@class AddToBagViewController;
@class MoreViewController;
@class BrowseViewController;
@class SpecialOffersViewController;

@interface RootViewController : UIViewController {
	
    
    
    IBOutlet UIView *loading;
	
    int indexSelectedInMorePage;
    
    WebContainer    *webContainer;
	
    Tabbar          *tabbar;
    
	NavigationBar   *navigationBar;
   
	ServiceHandler *serviceHandler;
	
	SearchViewController *searchViewController;
	
	HomeViewController	 *homeViewController;
    
    AddToBagViewController *myCartViewController;
    
    MoreViewController *moreViewController;
    
    BrowseViewController *browseViewController;
    
    SpecialOffersViewController *specialOffersViewController;
}
@property(nonatomic, retain) Tabbar *tabbar;
@property(nonatomic, retain) WebContainer    *webContainer;
@property(nonatomic, retain) NavigationBar   *navigationBar;

@property (nonatomic, retain) SearchViewController *searchViewController;

@property (nonatomic, retain) HomeViewController	 *homeViewController;

@property (nonatomic, retain) AddToBagViewController *myCartViewController;

@property (nonatomic, retain) MoreViewController *moreViewController;

@property (nonatomic, retain) BrowseViewController *browseViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;

//Start flow functions
-(void)addLoadingScreen;
-(void)removeLoadingScreen;
-(void)callConfigService;
-(void)configServiceCallDone:(NSMutableDictionary*)dictionary;
-(void)willStartLoadingFeaturedAssets;
-(void)willStartLoadingExtraAssets;

-(void)showTabbar;
-(UIView*)loadNavigationBar;

-(NSArray*)categoriseFeaturesWithRange:(NSRange)range;
-(void)addNativeControllerForIndex:(int)index toArray:(NSMutableArray*)controllers;
-(void)moreButtonsAction:(id)sender;
-(void)tabBarButtonAction:(id)sender;
-(void)showViewOfFeature:(NSString*)title userInfo:(NSDictionary*)userInfo;
-(void)willStartLoadingFeaturedAssets;

@end

