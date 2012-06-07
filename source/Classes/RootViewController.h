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

