//
//  iShop
//
//  Created by PHOTON on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Tabbar.h"
#import "WebContainer.h"
#import "NavigationBar.h"
#import "SharedObjects.h"
#import "ServiceHandler.h"
#import "DataModelEntities.h"
#import "Constants.h"
#import "FileManager.h"
#import "UIUtils.h"
#import "DebugOutput.h"
#import "SearchViewController.h"
#import "HomeViewController.h"
#import "AddToBagViewController.h"
#import "MoreViewController.h"
#import "BrowseViewController.h"
#import "ServiceHandler.h"
#import "SpecialOffersViewController.h"

@implementation RootViewController

@synthesize webContainer;
@synthesize tabbar;
@synthesize navigationBar;
@synthesize searchViewController;
@synthesize homeViewController;
@synthesize myCartViewController;
@synthesize moreViewController;
@synthesize browseViewController;
@synthesize specialOffersViewController;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	serviceHandler = [[ServiceHandler alloc] init];
	
	//Startup Flow::
	//1. Call the config service
	//2. On its callback, download all the assets
    [self addLoadingScreen];
    
	[self callConfigService];
}

//1.download Config File
//2. Read Stored Config File from Cache
//3. Check Version of app in config file with current app version
//		if app version is not latest, exit app go to itunes
//4. Check Config file version with cached file vs downloaded config
//		if version is different, download and cache the assets
//		else if same version, load assets from cache
- (void)addLoadingScreen {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    }
    else {
    [self.view addSubview:loading];
    [self.view bringSubviewToFront:loading];
    }
}

- (void)removeLoadingScreen {
    [loading removeFromSuperview];
}

-(void) callConfigService {

	//1. Downloading the config file
	
	//ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
	
	[serviceHandler configService:self :@selector(configServiceCallDone:)];
	
	//[serviceHandler release];
}


-(void) configServiceCallDone:(NSMutableDictionary*) dictionary
{
	AssetsDataEntity *assetsEntity = [[SharedObjects sharedInstance] assetsDataEntity];
    
    assetsEntity.appInfo = dictionary;
    	
    [assetsEntity updateFeaturedAssetModel:dictionary];
    
    [assetsEntity updatedAppFeatureLayout:dictionary];
    
    [self willStartLoadingFeaturedAssets];
	
}

- (void) willStartLoadingFeaturedAssets {
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabbar) name:kAllAssetsDownloadedNotification object:NULL];	
	
	//Now we have featured asset model ready. We can start downloading images for all featured assets
	AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
	
	for (int i = 0; i < [assetsData.assets count]; i++) {
		
		[assetsData startLoadingFeaturedAssets:[assetsData.assets objectAtIndex:i]];
	}
}


- (void) willStartLoadingExtraAssets {
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(loadNavigationBar) 
												 name:kExtraAssetsDownloadedNotification 
											   object:NULL];	
	
	AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
	
	for (int i = 0; i < [assetsData.extraAssets count]; i++) {
		
		[assetsData startLoadingExtraAssets:[assetsData.extraAssets objectAtIndex:i]];
	}
	
}

- (UIView*) loadNavigationBar {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kExtraAssetsDownloadedNotification object:NULL];
	
	NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
	
	[navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];
	
	return navBar;
}

- (void) showTabbar {		
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kAllAssetsDownloadedNotification object:NULL];
	
	AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
	
	if(nil != tabbar) {
		[tabbar removeFromSuperview];
		[tabbar release];
		tabbar = nil;
	}
     if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         
         tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
     }
     else {
         
         tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
     }
    
    
    NSMutableArray *names = [NSMutableArray array];
    
    int startIndex = 0;
    
    int lastIndex = 4;
    
    for(int i = startIndex; i <= lastIndex; i++) {
        
        [names addObject:[assetsData.featureLayout objectAtIndex:i]];
    }
    
    //create tabbar with given features
    [tabbar initWithInfo:names];
    
    [self.view addSubview:(UIView*)tabbar];
    
    //set viewControllers to tabbar
    NSRange range = NSMakeRange(startIndex, lastIndex);
    
    NSArray *controllers = [[self categoriseFeaturesWithRange:range] retain];
    if ([controllers count] > 0) {        
        [tabbar setControllers:controllers];
        
    }        
    
    [controllers release];
    
	//iShopAppDelegate *delegate = (iShopAppDelegate*)[[UIApplication sharedApplication] delegate];
//	
//	if (nil != [delegate pushNotificationInfo]) {
//		[tabbar setSelectedIndex:4 fromSender:nil];
//		[self showViewOfFeature:[[delegate pushNotificationInfo] objectForKey:@"feature"] userInfo:[delegate pushNotificationInfo]];
//	}
//	else {
		[tabbar reloadFeatureTab:0];
		
		//[tabbar setSelectedIndex:0 fromSender:nil];
		
		//  [tabbar highlightTabAtIndex:0];		
	//}

	
    
    [self removeLoadingScreen];
	
	FileManager *fileManager = [[FileManager alloc] init];
	
	[fileManager writeAssetsToCache];
		
	[fileManager release];
}

- (NSArray*)categoriseFeaturesWithRange:(NSRange)range {
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    @try {
        for(int i = range.location; i <= range.length; i++) {

            if (![assetsData isFeatureNative:[assetsData.featureLayout objectAtIndex:i]]) {
                
                WebContainer *tWebContainer = [[WebContainer alloc] initWithNibName:@"WebContainer" bundle:nil];
                
				NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
				
				AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
				
				[navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				

				tWebContainer.iNavigationBar = navBar;	
				
				[navBar release];
                
                [tWebContainer addNavigationBar];
                
                [[[assetsData assets] objectAtIndex:i] setViewControler:tWebContainer];
                
                [controllers addObject:tWebContainer];
                
                [tWebContainer release];
            }
            else {
                [self addNativeControllerForIndex:i toArray:controllers];
                
                [[[assetsData assets] objectAtIndex:i] setViewControler:[controllers lastObject]];
            }
        }

    }
    @catch (NSException *exception) {
        debug(@"raised exception: %@", [exception reason]);
    }
    
    return controllers;
}

- (void)addNativeControllerForIndex:(int)index toArray:(NSMutableArray*)controllers {
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
    
    NSString *featureName = [assetsData.featureLayout objectAtIndex:index];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (![featureName compare:@"Home" options:NSCaseInsensitiveSearch]) {
            //initialize controller here and add that controller's insatnce to controllers
            
            NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 88)];
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
            
            HomeViewController        *tempHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController-iPAd" bundle:nil];
            
            self.homeViewController = tempHomeViewController;
            
            [tempHomeViewController release];
            
            [navBar release];
            
            [controllers addObject:homeViewController];

        }
        if (![featureName compare:@"Browse" options:NSCaseInsensitiveSearch]) {
            //initialize controller here and add that controller's insatnce to controllers
            
            NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 88)];
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
            
                       
            
            
        }
        
        if (![featureName compare:@"Search" options:NSCaseInsensitiveSearch]) {
            //initialize controller here and add that controller's insatnce to controllers
            
            NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 88)];
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
            
            
            
            [navBar release];
            
            
        }
        
        if (![featureName compare:@"MyCart" options:NSCaseInsensitiveSearch]) {
            //initialize controller here and add that controller's insatnce to controllers
            
            NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 88)];
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
            
            
        }
        
        if (![featureName compare:@"Offers" options:NSCaseInsensitiveSearch]) {
            //initialize controller here and add that controller's insatnce to controllers
            NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 88)];
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];
        }
        
        if (![featureName compare:@"More" options:NSCaseInsensitiveSearch]) {
            //initialize controller here and add that controller's insatnce to controllers
            
            NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 88)];
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            
            [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
            
            
           
        }
    }
    else {
   
    if (![featureName compare:@"Home" options:NSCaseInsensitiveSearch]) {
        //initialize controller here and add that controller's insatnce to controllers
        
        NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
        
        
        HomeViewController        *tempHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        
        self.homeViewController = tempHomeViewController;
        
        [tempHomeViewController release];
        
        [navBar release];
        
        [controllers addObject:homeViewController];
		
    }
    if (![featureName compare:@"Browse" options:NSCaseInsensitiveSearch]) {
        //initialize controller here and add that controller's insatnce to controllers
		
		NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				

        

    }

    if (![featureName compare:@"Search" options:NSCaseInsensitiveSearch]) {
        //initialize controller here and add that controller's insatnce to controllers
        
        NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
        
        
        
        [navBar release];
        
        
    }
    
    if (![featureName compare:@"MyCart" options:NSCaseInsensitiveSearch]) {
        //initialize controller here and add that controller's insatnce to controllers
		
		NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
        
        
    }
    
    if (![featureName compare:@"Offers" options:NSCaseInsensitiveSearch]) {
        //initialize controller here and add that controller's insatnce to controllers
        NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];
    }
    
    if (![featureName compare:@"More" options:NSCaseInsensitiveSearch]) {
        //initialize controller here and add that controller's insatnce to controllers
		
		NavigationBar *navBar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        [navBar setHeaderImages:(NSDictionary*)assetsData.headerImagesDict];				
        
    }
    }
}



- (void)moreButtonsAction:(id)sender {

   /* if ([sender isKindOfClass:[UIButton class]]) {
        
		morePressCount = 0;

        UIButton *button = (UIButton*)sender;
        
        NSString *title = [[button titleLabel] text];
        
		////// Support ////////////
		AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
		
		appInfoEntity.featureName = title;
		///////////////////////////
		
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
        
        int index = indexSelectedInMorePage = [assetsData indexOfAssetWithName:title];
        
        FeaturedAsset *featuredAsset = (FeaturedAsset*)[assetsData objectForAssetName:title];

        //MorePageController *moreController = (MorePageController*)[[tabbar viewControllers] objectAtIndex:tabbar.selectedIndex];
//        
//        [moreController.view addSubview:[featuredAsset.viewControler view]];
//        
//        [moreController.view bringSubviewToFront:[featuredAsset.viewControler view]];
        
        //if we are using this animation for adding feature's view, then it should be removed using dismissModalView
        [[UIUtils sharedInstance] presentModalView:[featuredAsset.viewControler view]];
        
        //[moreController reloadFeatureTab:index];

    }
    */
}

- (void)tabBarButtonAction:(id)sender {
	
	if ([sender isKindOfClass:[UIButton class]]) {
		
        UIButton *button = (UIButton*)sender;
        
        NSString *title = [[button titleLabel] text];
        
		
//		if(![title isEqualToString:@"More"])
//		{
//			AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
//			
//			appInfoEntity.featureName = title;
//			
//		}
//		if([title isEqualToString:@"Scan"])
//		{
//			
//			
//		}
//		if([title isEqualToString:@"More"])
//		{
//			morePressCount++;
//    
//		}
		
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
        
        int index = [assetsData indexOfAssetWithName:title];   
        
        NSLog(@"Current index %d", index);
        
        
        if([button.titleLabel.text isEqualToString:@"Home"])
        {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
                assetsData.catalogArray = [[NSMutableArray alloc]init];
                assetsData.specialProductsArray = [[NSMutableArray alloc]init];
                assetsData.productDetailArray = [[NSMutableArray alloc]init];
                assetsData.productArray = [[NSMutableArray alloc]init];
                assetsData.productReviewArray = [[NSMutableArray alloc]init];
                HomeViewController	*tempHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController-iPAd" bundle:nil];
                
                self.homeViewController = tempHomeViewController;
                // [self.view addSubview:homeViewController.view];
                [self showTabbar];
                [tempHomeViewController release];
            }
            else {
                AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
                assetsData.catalogArray = [[NSMutableArray alloc]init];
                assetsData.specialProductsArray = [[NSMutableArray alloc]init];
                assetsData.productDetailArray = [[NSMutableArray alloc]init];
                assetsData.productArray = [[NSMutableArray alloc]init];
                assetsData.productReviewArray = [[NSMutableArray alloc]init];
                /*HomeViewController	*tempHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
                
                self.homeViewController = tempHomeViewController;
                 [self.view addSubview:homeViewController.view];*/
                [self viewDidLoad];
               // [tabbar setSelectedIndex:0 fromSender:nil];
                
                //[tempHomeViewController release];
            }
        }
        else if([button.titleLabel.text isEqualToString:@"Browse"])
        {
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            assetsData.catalogArray = [[NSMutableArray alloc]init];
            assetsData.specialProductsArray = [[NSMutableArray alloc]init];
            assetsData.productDetailArray = [[NSMutableArray alloc]init];
            assetsData.productArray = [[NSMutableArray alloc]init];
            assetsData.productReviewArray = [[NSMutableArray alloc]init];
            ServiceHandler *serviceHandlerFile = [[ServiceHandler alloc] init];
            
            [serviceHandlerFile catalogService:self :@selector(finishedCatalogService:)];
            
            [serviceHandlerFile release];
            
        }
        
        else if([button.titleLabel.text isEqualToString:@"MyCart"])
        {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
                AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
                assetsData.catalogArray = [[NSMutableArray alloc]init];
                assetsData.specialProductsArray = [[NSMutableArray alloc]init];
                assetsData.productDetailArray = [[NSMutableArray alloc]init];
                assetsData.productArray = [[NSMutableArray alloc]init];
                assetsData.productReviewArray = [[NSMutableArray alloc]init];
                
            AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController-iPAd" bundle:nil];
            
            self.myCartViewController = tempResultViewController;
            
            [self.view addSubview:myCartViewController.view];
            
                tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
                
                NSMutableArray *names = [NSMutableArray array];
                
                int startIndex = 0;
                
                int lastIndex = 4;
                
                for(int i = startIndex; i <= lastIndex; i++) {
                    [names addObject:[assetsData.featureLayout objectAtIndex:i]];
                }
                
                //create tabbar with given features
                [tabbar initWithInfo:names];
                
                [self.view addSubview:(UIView*)tabbar];
                [tabbar setSelectedIndex:2 fromSender:nil];
            [tempResultViewController release];
                
            }
            else {
                
                AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
                assetsData.catalogArray = [[NSMutableArray alloc]init];
                assetsData.specialProductsArray = [[NSMutableArray alloc]init];
                assetsData.productDetailArray = [[NSMutableArray alloc]init];
                assetsData.productArray = [[NSMutableArray alloc]init];
                assetsData.productReviewArray = [[NSMutableArray alloc]init];
            
                AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
                
                self.myCartViewController = tempResultViewController;
                
                [self.view addSubview:myCartViewController.view];
                /*tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
            
               NSMutableArray *names = [NSMutableArray array];
            
              int startIndex = 0;
            
              int lastIndex = 4;
            
              for(int i = startIndex; i <= lastIndex; i++) {
                [names addObject:[assetsData.featureLayout objectAtIndex:i]];
            }
            
            //create tabbar with given features
            [tabbar initWithInfo:names];
            
            [self.view addSubview:(UIView*)tabbar];
                [tabbar setSelectedIndex:2 fromSender:nil];*/
            [tempResultViewController release];
            }
            
            
            
        }
        else if([button.titleLabel.text isEqualToString:@"Offers"])
        {
            
            AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
            assetsData.catalogArray = [[NSMutableArray alloc]init];
            assetsData.specialProductsArray = [[NSMutableArray alloc]init];
            assetsData.productDetailArray = [[NSMutableArray alloc]init];
            assetsData.productArray = [[NSMutableArray alloc]init];
            assetsData.productReviewArray = [[NSMutableArray alloc]init];
            
            ServiceHandler *serviceHandlerOffer = [[ServiceHandler alloc] init];
            
            [serviceHandlerOffer specialProductsService:self :@selector(finishedSpecialProductsService:)];
            
            [serviceHandlerOffer release];
            
            
            
        }
        else if([button.titleLabel.text isEqualToString:@"More"])
        {
             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                 
                 MoreViewController	*tempmyCartController = [[MoreViewController alloc] initWithNibName:@"MoreViewController-iPad" bundle:nil];
                 
                 self.moreViewController = tempmyCartController;
                  [self.view addSubview:moreViewController.view];
                 tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
                 
                 NSMutableArray *names = [NSMutableArray array];
                 
                 int startIndex = 0;
                 
                 int lastIndex = 4;
                 
                 for(int i = startIndex; i <= lastIndex; i++) {
                     [names addObject:[assetsData.featureLayout objectAtIndex:i]];
                 }
                 
                 //create tabbar with given features
                 [tabbar initWithInfo:names];
                 
                 [self.view addSubview:(UIView*)tabbar];
                 [tabbar setSelectedIndex:4 fromSender:nil];
                 [tempmyCartController release];
             }
             else {
                 
            MoreViewController	*tempmyCartController = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
            
            self.moreViewController = tempmyCartController;
             [self.view addSubview:moreViewController.view];
                 
                 /*tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
                 
                 NSMutableArray *names = [NSMutableArray array];
                 
                 int startIndex = 0;
                 
                 int lastIndex = 4;
                 
                 for(int i = startIndex; i <= lastIndex; i++) {
                     [names addObject:[assetsData.featureLayout objectAtIndex:i]];
                 }
                 
                 //create tabbar with given features
                 [tabbar initWithInfo:names];
                 
                 [self.view addSubview:(UIView*)tabbar];
                 [tabbar setSelectedIndex:4 fromSender:nil];*/
            [tempmyCartController release];
             }
            
            
            
        }
        //Scenario: If user has clicked any feature on more tab and 
        //user has tapped more tab more than one time than app should 
        //remove the last selected view from more tab and it should show more page.
//        if ([title isEqualToString:@"More"] && tabbar.selectedIndex == 4) {
//            
//            NSString *title = [assetsData featureNameWithIndex:indexSelectedInMorePage];
//            
//            indexSelectedInMorePage = [assetsData indexOfAssetWithName:title];
//            
//            FeaturedAsset *featuredAsset = (FeaturedAsset*)[assetsData objectForAssetName:title];
//            
//          MoreViewController *moreController = (MoreViewController*)[[tabbar viewControllers] objectAtIndex:tabbar.selectedIndex];
//            
//            if ([[featuredAsset.viewControler view] isDescendantOfView:moreController.view]) {
//                [[UIUtils sharedInstance] dismissModalView:[featuredAsset.viewControler view]];
//            }
//			
//		}
//		else
//		{
			//morePressCount = 0;
		//}
		
        [tabbar setSelectedIndex:index fromSender:sender];
		
    }    
}

-(void) finishedCatalogService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateCatalogModel:data];
    
     if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         
    BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController-iPad" bundle:nil];
    
    self.browseViewController = tempBrowseViewController;
    
    [self.view addSubview:browseViewController.view];
         
         tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
         
         NSMutableArray *names = [NSMutableArray array];
         
         int startIndex = 0;
         
         int lastIndex = 4;
         
         for(int i = startIndex; i <= lastIndex; i++) {
             [names addObject:[assetsData.featureLayout objectAtIndex:i]];
         }
         
         //create tabbar with given features
         [tabbar initWithInfo:names];
         
         [self.view addSubview:(UIView*)tabbar];
    [tabbar setSelectedIndex:1 fromSender:nil];
    [tempBrowseViewController release];
         
         

     }
     else {
         
    BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController" bundle:nil];
    
    self.browseViewController = tempBrowseViewController;
    
    [self.view addSubview:browseViewController.view];
    
        /* tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
         
         NSMutableArray *names = [NSMutableArray array];
         
         int startIndex = 0;
         
         int lastIndex = 4;
         
         for(int i = startIndex; i <= lastIndex; i++) {
             [names addObject:[assetsData.featureLayout objectAtIndex:i]];
         }
         
         //create tabbar with given features
         [tabbar initWithInfo:names];
         
         [self.view addSubview:(UIView*)tabbar];
         [tabbar setSelectedIndex:1 fromSender:nil];*/
    [tempBrowseViewController release];
          
         }
}

-(void) finishedSpecialProductsService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateSpecialproductsModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController-iPad" bundle:nil];
        
        self.specialOffersViewController = tempSpecialOffersViewController;
        
        [self.view addSubview:specialOffersViewController.view];
        
        tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
        
        NSMutableArray *names = [NSMutableArray array];
        
        int startIndex = 0;
        
        int lastIndex = 4;
        
        for(int i = startIndex; i <= lastIndex; i++) {
            [names addObject:[assetsData.featureLayout objectAtIndex:i]];
        }
        
        //create tabbar with given features
        [tabbar initWithInfo:names];
        
        [self.view addSubview:(UIView*)tabbar];
        [tabbar setSelectedIndex:3 fromSender:nil];
        [tempSpecialOffersViewController release];
    }
    else {
        
        SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
        
        self.specialOffersViewController = tempSpecialOffersViewController;
        
        [self.view addSubview:specialOffersViewController.view];
        
       /* tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
        
        NSMutableArray *names = [NSMutableArray array];
        
        int startIndex = 0;
        
        int lastIndex = 4;
        
        for(int i = startIndex; i <= lastIndex; i++) {
            [names addObject:[assetsData.featureLayout objectAtIndex:i]];
        }
        
        //create tabbar with given features
        [tabbar initWithInfo:names];
        
        [self.view addSubview:(UIView*)tabbar];
        [tabbar setSelectedIndex:3 fromSender:nil];*/
        [tempSpecialOffersViewController release];
    }
    
}
- (void)showViewOfFeature:(NSString*)title userInfo:(NSDictionary*)userInfo {
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;	
    
    int index = indexSelectedInMorePage = [assetsData indexOfAssetWithName:title];
    
    if (index >= 0) {
        
        @try {
            FeaturedAsset *featuredAsset = (FeaturedAsset*)[assetsData.assets objectAtIndex:index];
            
            if (!featuredAsset.isInTabbar) {
                
                if ([featuredAsset.viewControler respondsToSelector:@selector(loadCouponWithUrl:)]) {
                    
                    if (nil != userInfo) {              
                        NSString *couponUrlString = [userInfo objectForKey:@"coupon_display_image"];
                        if (nil != couponUrlString) {
                            NSURL *url = [NSURL URLWithString:couponUrlString];
                            [featuredAsset.viewControler loadCouponWithUrl:url];
                        }
                    } 
                }		
                
           //     MorePageController *moreController = (MorePageController*)[[tabbar viewControllers] objectAtIndex:4];
//                
//                [moreController.view addSubview:[featuredAsset.viewControler view]];
//                
//                [moreController.view bringSubviewToFront:[featuredAsset.viewControler view]];
                
                //if we are using this animation for adding feature's view, then it should be removed using dismissModalView
                [[UIUtils sharedInstance] presentModalView:[featuredAsset.viewControler view]];            
            }
        }
        @catch (NSException *exception) {
            debug(@"exception");
        }
    }

	//iShopAppDelegate *delegate = (iShopAppDelegate*)[[UIApplication sharedApplication] delegate];
//	[delegate releasePushNotificationInfo];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
	
	//if OK button is clicked then redirect to iTunes url
	
	if(buttonIndex==0)
	{
		NSURL *url=[[NSURL alloc]initWithString:appInfoEntity.versionUpdateUrl];
		
		[[UIApplication sharedApplication] openURL:url];
		
	}

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {

	[serviceHandler release];
	
	[homeViewController release];
    
    [moreViewController release];
	
    [super dealloc];
}

@end
